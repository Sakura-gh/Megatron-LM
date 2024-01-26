def calculate_ratio(doc_length_count):
    
    # 计算总计数
    total_count = sum(doc_length_count.values())
    
    # 初始化一个空字典来存储比例
    ratio = {}
    
    # 计算每个长度的比例并存储在新字典中
    for length, count in doc_length_count.items():
        ratio[length] = count / total_count

    return ratio

doc_length_count = {'128': 36119, '256': 40021, '512': 40767, '1024': 34592, '2048': 15865, '4096': 5112, '8192': 1665, '16384': 563, '>16k': 213}
# doc_length_count = {'128': 15356, '256': 21272, '512': 34836, '1024': 39366, '2048': 27627, '4096': 12145, '8192': 4128, '16384': 1315, '>16k': 244}

ratio = calculate_ratio(doc_length_count)

print("ratio: ", ratio)
