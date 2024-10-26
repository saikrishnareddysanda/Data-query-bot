import streamlit as st
import os
from core.chat_manager import ChatManager

# Paths for main folders
MAIN_FOLDERS = {
    "bird": "./data/bird",
    "spider": "./data/spider"
}

# Select main folder
folder_name = st.selectbox("Select Main Folder:", list(MAIN_FOLDERS.keys()))

# Dynamically load db_ids from the selected folder
if folder_name == 'spider':
    db_path = MAIN_FOLDERS[folder_name] + "/database"
else:
    db_path = MAIN_FOLDERS[folder_name] + "/dev_databases"
db_ids = [name for name in os.listdir(db_path) if os.path.isdir(os.path.join(db_path, name))]

# Dropdown for selecting the database ID
db_id = st.selectbox("Select the Database ID:", db_ids)

# Input field for the user query
query = st.text_input("Enter your query:")

# Button to trigger the action
if st.button("Submit"):
    if folder_name == 'spider':
        table_name = "tables.json"
    else:
        table_name = "dev_tables.json"

    # Initialize ChatManager based on selected main folder and db_id
    chat_manager = ChatManager(
        data_path=db_path,
        tables_json_path=os.path.join(MAIN_FOLDERS[folder_name], table_name),
        log_path="./cli_run",
        dataset_name=folder_name,
        model_name="llama",
        lazy=True,
        without_selector=False,
    )

    # Construct the user_message
    user_message = {
        "idx": 0,
        "db_id": db_id,
        "query": query,
        "evidence": "",
        "extracted_schema": {},
        "ground_truth": "",
        "difficulty": "",
        "send_to": "System",
    }

    # Start the chat_manager and process the user message
    chat_manager.start(user_message)

    # Display the output
    st.write("Output")
    
    # Assuming the output dictionary keys exist in user_message
    output = {
        "selector": user_message.get('selector', ''),
        "decomposer": user_message.get('decomposer', ''),
        "refiner": user_message.get('refiner', '')
    }
    
    st.json(output)
