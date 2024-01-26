python3 tools/preprocess_data.py \
       --input data/wiki/wiki.json \
       --json-keys text \
       --output-prefix wiki \
       --vocab-file /home/gehao/data/hf-GPT2Data/vocab.json \
       --tokenizer-type GPT2BPETokenizer \
       --merge-file /home/gehao/data/hf-GPT2Data/merges.txt \
       --workers 1 \
       --chunk-size 1 \
       --append-eod