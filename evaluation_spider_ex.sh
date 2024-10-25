# #################### Spider dev 【evaluation】EX and EM count=1034 #########
python ./evaluation/evaluation_spider.py \
   --gold "./data/spider/dev_gold.sql" \
   --db "./data/spider/database" \
   --table "./data/spider/tables.json" \
   --pred "./outputs/spider/pred_dev.sql" \
   --etype "exec"
