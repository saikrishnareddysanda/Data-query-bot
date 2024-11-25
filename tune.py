import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
from datasets import Dataset
from peft import get_peft_model, LoraConfig, TaskType
import bitsandbytes as bnb

device = "cuda" if torch.cuda.is_available() else "cpu"

torch.random.manual_seed(0)


import os
import wandb
from transformers import AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments

from peft import LoraConfig, get_peft_model

import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
from datasets import Dataset
import os
import wandb


from transformers import AutoModelForCausalLM, AutoTokenizer, BitsAndBytesConfig
from peft import LoraConfig, get_peft_model
from peft import get_peft_model, LoraConfig, TaskType  # Ensure TaskType is imported
from transformers import AutoTokenizer, AutoModelForCausalLM, TrainingArguments, Trainer

device = "cuda" if torch.cuda.is_available() else "cpu"
# Define quantization configuration for 8-bit
quantization_config = BitsAndBytesConfig(
    load_in_8bit=True,  # Use 8-bit quantization
)

# Load model and tokenizer with 8-bit quantization
model_name = "microsoft/Phi-3.5-mini-instruct"
tokenizer = AutoTokenizer.from_pretrained(model_name)

model = AutoModelForCausalLM.from_pretrained(
    model_name,
    device_map="auto",  # Automatically map layers to GPUs
    quantization_config=quantization_config,  # Apply 8-bit quantization
    trust_remote_code=True,  # Enable custom model code
)

# LoRA Configuration
lora_config = LoraConfig(
    r=8,  # Rank of the low-rank matrices
    lora_alpha=16,  # Scaling factor
    target_modules=["qkv_proj", "o_proj"],  # Specify target modules
    task_type=TaskType.CAUSAL_LM  # Specify task type
)

# Apply LoRA configuration to the model
model = get_peft_model(model, lora_config)

#Load tokenizer
tokenizer = AutoTokenizer.from_pretrained("microsoft/Phi-3.5-mini-instruct")

# Function to load and preprocess the Spider dataset
def load_spider_dataset_with_keys(dev_file, tables_file):
    import json
    with open(dev_file, 'r') as f:
        dev_data = json.load(f)
    with open(tables_file, 'r') as f:
        tables_data = json.load(f)
    
    db_schemas = {table['db_id']: table for table in tables_data}
    examples = []
    for item in dev_data:
        db_id = item['db_id']
        question = item['question']
        sql_query = item['query']
        
        db_schema = db_schemas[db_id]
        schema_str = []
        for table_name, table_index in zip(db_schema['table_names'], range(len(db_schema['table_names']))):
            columns = [col[1] for col in db_schema['column_names'] if col[0] == table_index]
            primary_keys = [db_schema['column_names'][pk][1] for pk in db_schema['primary_keys'] if db_schema['column_names'][pk][0] == table_index]
            pk_info = f" (Primary Key: {', '.join(primary_keys)})" if primary_keys else ""
            schema_str.append(f"Table: {table_name} Columns: {', '.join(columns)}{pk_info}")
        
        fk_info = []
        for fk_pair in db_schema['foreign_keys']:
            col1_name = db_schema['column_names'][fk_pair[0]][1]
            table1_name = db_schema['table_names'][db_schema['column_names'][fk_pair[0]][0]]
            col2_name = db_schema['column_names'][fk_pair[1]][1]
            table2_name = db_schema['table_names'][db_schema['column_names'][fk_pair[1]][0]]
            fk_info.append(f"{table1_name}.{col1_name} -> {table2_name}.{col2_name}")
        if fk_info:
            schema_str.append("Foreign Key Relationships: " + "; ".join(fk_info))
        
        input_text = f"Schema:\n" + "\n".join(schema_str) + f"\nQuestion: {question}\nSQL:"
        examples.append({"input": input_text, "output": sql_query})
    
    return examples

# Tokenization function
def tokenize_function(examples):
    inputs = tokenizer(examples['input'], truncation=True, padding='max_length', max_length=2048)
    outputs = tokenizer(examples['output'], truncation=True, padding='max_length', max_length=2048)
    inputs['labels'] = outputs['input_ids']
    return inputs

if __name__ == "__main__":
    dataset_path = './spider/dev.json'
    tables_path  = './spider/tables.json'

    # Set Hugging Face token
    os.environ['HUGGINGFACE_HUB_TOKEN'] = "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"

    # Log in to W&B (Weights & Biases)
    wandb.login(key="ace9bb699f102bb3b987820204a69c01d30fcc76")

    # Load and preprocess the Spider dataset
    spider_data = load_spider_dataset_with_keys(dataset_path, tables_path)
    dataset = Dataset.from_dict({
        'input': [item['input'] for item in spider_data],
        'output': [item['output'] for item in spider_data]
    })
    tokenized_dataset = dataset.map(tokenize_function, batched=True, remove_columns=['input', 'output'])
    spider_data = load_spider_dataset_with_keys(dataset_path, tables_path)
    dataset = Dataset.from_dict({
            'input': [item['input'] for item in spider_data],
            'output': [item['output'] for item in spider_data]
        })

    tokenized_dataset = dataset.map(
        tokenize_function, 
        batched=True, 
        remove_columns=['input', 'output']
    )

    # Training arguments with updated batch size
    training_args = TrainingArguments(
        output_dir='./fine_tuned_phi3.5_sql',
        learning_rate=5e-5,
        per_device_train_batch_size=1,  # Set to 2 for smaller batch size
        gradient_accumulation_steps=1,  # No accumulation for a batch size of 2
        num_train_epochs=3,
        logging_dir='./logs',
        logging_steps=50,
        save_total_limit=2,
        fp16=True,  # Mixed precision
    )

    # Initialize Trainer
    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=tokenized_dataset,
        tokenizer=tokenizer
    )

    # Fine-tune the model
    trainer.train()

    # Save the fine-tuned model and tokenizer
    model.save_pretrained('./fine_tuned_phi3.5_sql_8bit')
    tokenizer.save_pretrained('./fine_tuned_phi3.5_sql_8bit')

    # Testing the model
    #test_input = "Write an SQL query to fetch employee names with salary greater than 5000."
    #inputs = tokenizer(test_input, return_tensors="pt").to(device)
    #outputs = model.generate(**inputs, max_length=128)
    #print("Generated SQL:", tokenizer.decode(outputs[0], skip_special_tokens=True))
