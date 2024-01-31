bash benchmark/benchmark_packing_4k.sh 2>&1 | tee benchmark_packing_4k.log

bash benchmark/benchmark_padding_4k.sh 2>&1 | tee benchmark_padding_4k.log

bash benchmark/benchmark_packing_8k.sh 2>&1 | tee benchmark_packing_8k.log

bash benchmark/benchmark_padding_8k.sh 2>&1 | tee benchmark_padding_8k.log

bash benchmark/benchmark_packing_16k.sh 2>&1 | tee benchmark_packing_16k.log

bash benchmark/benchmark_padding_16k.sh 2>&1 | tee benchmark_padding_16k.log