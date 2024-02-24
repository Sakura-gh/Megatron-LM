# coding=utf-8

import os, sys, traceback
import re
import numpy as np
from collections import defaultdict, OrderedDict


NUMBER_PATTERN = "([+-]?([0-9]+([.][0-9]*)?|[.][0-9]+))"

NEW_CONF_PATTERN = (
    r"(?P<model_size>NUMBER)b, " + 
    r"(?P<seq_len>NUMBER)k, " + 
    r"gbs=(?P<gbs>NUMBER): " + 
    r"dp=(?P<dp>NUMBER), "
    r"tp=(?P<tp>NUMBER), "
    r"pp=(?P<pp>NUMBER), "
    r"mbs=(?P<mbs>NUMBER)"
    ).replace("NUMBER", NUMBER_PATTERN)


# ELAPSED_TIME_PATTERN = (
#     r"iteration([^0-9]*)(?P<iter_id>NUMBER)/([^0-9]*)(?P<total_iter>NUMBER)" + 
#     r"(.*)elapsed time per iteration([^0-9]*)(?P<elapsed_per_iter>NUMBER)"
#     ).replace("NUMBER", NUMBER_PATTERN)

ELAPSED_TIME_PATTERN = (
    r"iteration([^0-9]*)(?P<iter_id>NUMBER)/([^0-9]*)(?P<total_iter>NUMBER)" + 
    r"(.*)elapsed time per iteration([^0-9]*)(?P<elapsed_per_iter>NUMBER)" + 
    r"(.*)global batch size([^0-9]*)(?P<gbs>NUMBER)"
    ).replace("NUMBER", NUMBER_PATTERN)


# 'iteration       70/     100 | consumed samples:        35840 | elapsed time per iteration (ms): 11897.8 | learning rate: 3.281E-06 | global batch size:   512 | lm loss: 1.074161E+01 | loss scale: 1.0 | grad norm: 0.142 | number of skipped iterations:   0 | number of nan iterations:   0 |'


def parse_new_conf(line):
    matches = re.search(NEW_CONF_PATTERN, line)
    if matches is None:
        return None
    else:
        match = matches.groupdict()
        keys = ['model_size', 'seq_len', 'gbs', 'dp', 'tp', 'pp', 'mbs']
        ret = OrderedDict()
        for k in keys:
            ret[k] = int(match[k])
        return ret


def parse_elapsed_time(line):
    matches = re.search(ELAPSED_TIME_PATTERN, line)
    if matches is None:
        return None
    else:
        match = matches.groupdict()
        ret = OrderedDict()
        ret['iter_id'] = int(match['iter_id'])
        ret['total_iter'] = int(match['total_iter'])
        ret['elapsed_per_iter'] = float(match['elapsed_per_iter'])
        ret['gbs'] = int(match['gbs'])
        return ret


TIMEOUT_ERROR = "torch.distributed.elastic.agent.server.api: [WARNING] Received Signals.SIGTERM death signal, shutting down workers"
OOM_ERROR = "CUDA out of memory"
ILLEGAL_MEMORY_ERROR = "CUDA error: an illegal memory access was encountered"
CUDA_INVALID_CONF_ERROR = "CUDA error: invalid configuration argument"
NCCL_UNHANDLED_ERROR = "ncclUnhandledCudaError: Call to CUDA function failed"
INVALID_DP_ERROR = "DP must equal to"
INVALID_TP_ERROR = "is not divisible by"
INVALID_PP_ERROR = "AssertionError: num_layers must be divisible by transformer_pipeline_model_parallel_size"

ALL_ERRORS = [TIMEOUT_ERROR, OOM_ERROR, CUDA_INVALID_CONF_ERROR]
ALL_ERRORS = {
    ('timeout', TIMEOUT_ERROR), 
    ('oom', OOM_ERROR), 
    ('illegal_memory_access', ILLEGAL_MEMORY_ERROR),
    ('cuda_invalid_conf_argument', CUDA_INVALID_CONF_ERROR),
    ('nccl_handled_error', NCCL_UNHANDLED_ERROR),
    ('invalid_dp_error', INVALID_DP_ERROR),
    ('invalid_tp_error', INVALID_TP_ERROR),
    ('invalid_pp_error', INVALID_PP_ERROR),
}


def parse_failed_reason(line):
    for error_reason, error_msg in ALL_ERRORS:
        if line.find(error_msg) >= 0:
            return error_reason
    return None


def parse_log_file(file, pack_or_pad, accompanied_file=None):
    assert pack_or_pad in ('pack', 'pad'), f"Invalid packing or padding: {pack_or_pad}"
    
    def record_one_expr(one_conf, one_conf_str, one_time_info, exit_reason):
        if len(one_time_info) == 0:
            if exit_reason is None:
                raise Exception(f"No failure reason for {one_conf}")
            return
            print(one_conf_str)
            #print(one_conf)
            print("Failed. Reason: " + (exit_reason or 'Not Provided!!!'))
        else:
            # ###
            # script_name = "benchmark/test_padding.sh.two.bak"
            # # script_name = "benchmark/test_packing.sh.two.bak"
            # if one_conf['model_size'] == 7:
            #     model_conf_args = "32 4096 32"
            # elif one_conf['model_size'] == 13:
            #     model_conf_args = "40 5120 40"
            # else:
            #     raise Exception()
            # model_conf_args += f" {one_conf['seq_len'] * 1024}"
            # print(f"echo \"{one_conf['model_size']}b, {one_conf['seq_len']}k, gbs={one_conf['gbs']}: dp={one_conf['dp'] * 2}, tp={one_conf['tp']}, pp={one_conf['pp']}, mbs={one_conf['mbs']}\"")
            # print(f"timeout 1h bash {script_name} {one_conf['dp'] * 2} {one_conf['tp']} {one_conf['pp']} {model_conf_args} {one_conf['mbs']} {one_conf['gbs']}")
            # print("bash ssh_and_kill.sh")
            # print("sleep 30")
            # print()
            # return
            ###
            one_time_info = np.array(one_time_info)
            mean = np.mean(one_time_info)
            stddev = np.std(one_time_info)
            mean_except_first, stddev_except_first = float("nan"), float("nan")
            if len(one_time_info) > 1:
                mean_except_first = np.mean(one_time_info[1:])
                stddev_except_first = np.std(one_time_info[1:])
            #print(one_conf_str)
            # print(one_conf)
            # print(f"elapsed_time_per_iter={one_time_info}, mean={mean:.3f}, stddev={stddev:.3f}, cv={stddev/mean:.3f}")
            print(','.join([str(x) for x in [
                one_conf['model_size'], one_conf['seq_len'], pack_or_pad, one_conf['gbs'], one_conf['mbs'], 
                one_conf['dp'], one_conf['tp'], one_conf['pp'], 
                f"{mean_except_first:.3f}", f"{stddev_except_first:.3f}", 
                exit_reason or "success", 
                f"{mean:.3f}", f"{stddev:.3f}", f"\"[{','.join(str(v) for v in one_time_info)}]\""
                ]]))
    

    accompanied_failed_reasons = {}
    cur_conf = None
    cur_conf_str = None
    failed_reason = None
    if accompanied_file is not None:
        with open(accompanied_file) as fd:
            for line in fd:
                line = line.strip('\n')
                matched_new_conf = parse_new_conf(line)
                if matched_new_conf is not None:
                    if cur_conf is not None:
                        accompanied_failed_reasons[cur_conf_str] = failed_reason
                        cur_conf = None
                        cur_conf_str = None
                        failed_reason = None
                    cur_conf = matched_new_conf
                    cur_conf_str = line
                    continue
                # pass
                if failed_reason is None:
                    failed_reason = parse_failed_reason(line)
                    if failed_reason == 'cuda_invalid_conf_argument':
                        assert int(cur_conf['mbs']) == 1, f"Got {failed_reason} when mbs={cur_conf['mbs']}"
                        continue
                    else:
                        continue
        if cur_conf is not None:
            accompanied_failed_reasons[cur_conf_str] = failed_reason


    cur_conf = None
    cur_conf_str = None
    time_info = []
    failed_reason = None
    with open(file) as fd:
        for line in fd:
            line = line.strip('\n')
            matched_new_conf = parse_new_conf(line)
            if matched_new_conf is not None:
                if cur_conf is not None:
                    exit_reason = failed_reason
                    accompanied_failed_reason = accompanied_failed_reasons.get(cur_conf_str, None)
                    if accompanied_failed_reason is not None:
                        if exit_reason is not None:
                            exit_reason = f"{exit_reason}:{accompanied_failed_reason}"
                        else:
                            exit_reason = accompanied_failed_reason
                    record_one_expr(cur_conf, cur_conf_str, time_info, exit_reason=exit_reason)
                    cur_conf = None
                    cur_conf_str = None
                    time_info = []
                    failed_reason = None
                cur_conf = matched_new_conf
                cur_conf_str = line
                continue
            # pass
            elapsed_time_dict = parse_elapsed_time(line)
            if elapsed_time_dict is not None:
                assert failed_reason is None, \
                    f"Found elapsed time after failure. Failed reason: {failed_reason}. Conf: {cur_conf}. Line: {line}"
                assert elapsed_time_dict['total_iter'] == 100, \
                    f"invalid total iter id {elapsed_time_dict['total_iter']} in line: {line}"
                assert elapsed_time_dict['iter_id'] == ((len(time_info) + 1) * 10), \
                    f"unexpected iter id {elapsed_time_dict['iter_id']} (expected {(len(time_info) + 1) * 10}) in line: {line}"
                assert elapsed_time_dict['gbs'] == cur_conf['gbs'], \
                    f"invalid global batch size {elapsed_time_dict['gbs']} in line: {line}"
                time_info.append(elapsed_time_dict['elapsed_per_iter'])
                continue
            # pass
            if failed_reason is None:
                # only match the first failure reason
                failed_reason = parse_failed_reason(line)
                if failed_reason == 'cuda_invalid_conf_argument':
                    assert int(cur_conf['mbs']) == 1, f"Got {failed_reason} when mbs={cur_conf['mbs']}"
                continue
            else:
                continue
    # pass
    if cur_conf is not None:
        exit_reason = failed_reason
        accompanied_failed_reason = accompanied_failed_reasons.get(cur_conf_str, None)
        if accompanied_failed_reason is not None:
            if exit_reason is not None:
                exit_reason = f"{exit_reason},{accompanied_failed_reason}"
            else:
                exit_reason = accompanied_failed_reason
        record_one_expr(cur_conf, cur_conf_str, time_info, exit_reason=exit_reason)


if __name__ == '__main__':
    files = [
        ###### single node, all succedded
        # ('benchmark/logs/gpus8/7b/4k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/7b/4k_packing_gbs512.log', None), 
        # ('benchmark/logs/gpus8/7b/8k_packing_gbs512.log', None), 
        # ('benchmark/logs/gpus8/7b/8k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/7b/16k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/7b/16k_packing_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/4k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/4k_packing_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/8k_packing_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/8k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/16k_padding_gbs512.log', None), 
        # ('benchmark/logs/gpus8/13b/16k_packing_gbs512.log', None), 

        ###### two nodes, part succedded
        #('benchmark/logs/gpus16/7b/16k_packing_gbs512_node1.log', 'benchmark/logs/gpus16/7b/16k_packing_gbs512_node2.log'), 
        #('benchmark/logs/gpus16/7b/16k_padding_gbs512_node1.log', 'benchmark/logs/gpus16/7b/16k_padding_gbs512_node2.log'), 
        #('benchmark/logs/gpus16/7b/8k_padding_gbs512_node2.log', 'benchmark/logs/gpus16/7b/8k_padding_gbs512_node1.log'), 

        ###### two nodes, part selective
        #('benchmark/logs/gpus16/13b/selective_16k_packing_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_16k_packing_gbs512_node1.log'),
        #('benchmark/logs/gpus16/13b/selective_4k_packing_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_4k_packing_gbs512_node1.log'),
        #('benchmark/logs/gpus16/13b/selective_4k_padding_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_4k_padding_gbs512_node1.log'),
        #('benchmark/logs/gpus16/13b/selective_8k_packing_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_8k_packing_gbs512_node1.log'),
        #('benchmark/logs/gpus16/13b/selective_8k_padding_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_8k_padding_gbs512_node1.log'),
        #('benchmark/logs/gpus16/7b/selective_4k_packing_gbs512_node2.log', 'benchmark/logs/gpus16/7b/selective_4k_packing_gbs512_node1.log'),
        #('benchmark/logs/gpus16/7b/selective_4k_padding_gbs512_node2.log', 'benchmark/logs/gpus16/7b/selective_4k_padding_gbs512_node1.log'),
        #('benchmark/logs/gpus16/7b/selective_8k_packing_gbs512_node2.log', 'benchmark/logs/gpus16/7b/selective_8k_packing_gbs512_node1.log'),

        ##### two nodes, hand-crafted
        ('benchmark/logs/gpus16/13b/selective_16k_packing_gbs512_node2.log.appended', 'benchmark/logs/gpus16/13b/selective_16k_packing_gbs512_node1.log.appended'),
        ('benchmark/logs/gpus16/13b/selective_16k_padding_gbs512_node2.log', 'benchmark/logs/gpus16/13b/selective_16k_padding_gbs512_node1.log'),
    ]
    print("model_size,seq_len,pack_or_pad,gbs,mbs,dp,tp,pp,mean_except_first,stddev_except_first,exit_reason,mean,stddev,values")
    for file, accompanied_file in files:
        # print(f'===== {file}, {accompanied_file} =====')
        # print("model_size,seq_len,gbs,mbs,dp,tp,pp,mean_except_first,stddev_except_first,exit_reason,mean,stddev,values")
        pack_or_pad = 'pack' if file.find('pack') >= 0 else 'pad'
        parse_log_file(file, pack_or_pad, accompanied_file=accompanied_file)

