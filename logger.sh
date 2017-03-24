#!/bin/bash

count_lines(){
  #. $1 => name of the file
  numberoflines="$(cat $1 | wc -l)"
  datetime="$(date --iso-8601=seconds)"
  echo "$datetime | $1 | $numberoflines" >> /root/counts.log
}

get_filename() {
  #. $1 => the name of the directory
  for file in `find $1 -name '*.log' -type f`; do
    count_lines "$file"
  done
}

get_filename "/var/log"
