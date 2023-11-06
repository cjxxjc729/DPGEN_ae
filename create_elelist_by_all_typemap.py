#!/public1/home/sch0149/deepmd-kit/bin/python

import os
import sys

def find_files(startpath, filename):
    matches = []
    for root, dirnames, filenames in os.walk(startpath):
        for fname in filenames:
            if fname == filename:
                matches.append(os.path.join(root, fname))
    return matches

def merge_files_content(filepaths, uniq=False):
    merged_content = []

    for filepath in filepaths:
        with open(filepath, 'r') as file:
            lines = file.readlines()

            # 如果选择了uniq选项，则仅添加之前未添加过的行
            if uniq:
                for line in lines:
                    if line not in merged_content:
                        merged_content.append(line)
            else:
                merged_content.extend(lines)

    return ''.join(merged_content)

# 使用例子
files_to_merge = find_files(sys.argv[1], 'type_map.raw')
merged_content = merge_files_content(files_to_merge, uniq=True)

# 如果你要保存合并后的内容到新文件中
with open('ele_list.t', 'w') as output_file:
    output_file.write(merged_content)

