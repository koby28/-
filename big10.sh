#!/bin/bash
#找出某个目录下最大的10个文件
du -ak $SOURCE_DIR | sort -nrk 1 | head
