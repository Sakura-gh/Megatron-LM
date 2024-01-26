python3 tools/preprocess_data.py \
       --input data/refinedweb/refinedweb0.json \
       --json-keys content \
       --output-prefix refinedweb0 \
       --vocab-file /home/gehao/data/hf-GPT2Data/vocab.json \
       --tokenizer-type GPT2BPETokenizer \
       --merge-file /home/gehao/data/hf-GPT2Data/merges.txt \
       --workers 1 \
       --chunk-size 1 \
       --append-eod