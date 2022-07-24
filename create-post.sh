#! /bin/bash

cd ~/Proyects/bitbyte-blog/src/posts

read -p "Post Name: " post_name

file_name="$(
  echo $post_name | 
  awk '{print tolower($0)}' | 
  sed 's/ /_/g').md"

read -p "Description : " post_desc
read -p "Featured post?: (y/n) " -n 1 featured
echo ""
read -p "Tags: " -a tags

pos=1
tag_length=${#tags[@]}
for tag in "${tags[@]}"; do
  if [ "$pos" -eq "$tag_length" ]; then
    line_tag+="'${tag}'"
  else
    line_tag+="'${tag}',"
  fi
    ((pos += 1))
done

cat > $file_name <<EOL
---
title: $post_name
date: $(date +%Y-%m-%d)
description: $post_desc
featured: $([ "$featured" == "y" ] && echo "true" || echo "false")
tags: [$line_tag]
---

# Header 1 

## Header 2 

### Header 3 

EOL

nvim "$file_name"
