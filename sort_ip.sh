#!/bin/bash +x

while :; do

    Keyword=($(ls ./logs/* | awk -F/ '{print $3}' | awk -F. '{print $1}' | uniq))

    echo -en "請輸入要指定的檔案關鍵字 :\n"
    echo "退出請按q"
    for key in ${!Keyword[@]}; do
        echo "$key ${Keyword[$key]}"
    done

    read keyword_num
    if [ $keyword_num == "q" ]; then
        echo "退出"
        exit
    fi

    keyword=${Keyword[keyword_num]}
    # 列出檔案
    Files=($(ls -td ./logs/*| grep $keyword))


    # 輸入檔案編號
    echo -en "請輸入要查看的檔案 :\n"
    echo "退出請按q"
    for key in ${!Files[@]}; do
        echo "$key ${Files[$key]:7}"
    done

    read file_num
    if [ $file_num == "q" ]; then
        echo "退出"
        exit
    fi

    file=${Files[file_num]}

    # 確認是否為壓縮檔
    if [[ $file =~ gz.*$ ]]; then
        cat="zcat"
    else
        cat="cat"
    fi

    # 輸入日期
    #echo '此份log日期'
    #echo $(awk  'BEGIN{OFS=" ";}{print $1}' $file |uniq )
    #echo '------------- 時間範圍 -------------'
    total=`$cat $file |wc -l | awk '{print $1}'`
    #echo $(awk  '{print $2}' $file | sort | head -1 ) '~' $(awk  '{print $2}' $file | sort -r | head -1 )
    echo -en "請輸入要查看的日期以及時間(如需要全列出請按enter) :\n"
    # 時間判斷
    read timestamp
    if  [ "$timestamp" == "q" ]; then
        echo "退出"
        exit
    fi

    echo '---------------------------------- ip狀態 ----------------------------------'
    if [ -n "$timestamp" ]; then
    vals=($total $timestamp)
    $cat $file | sort  | awk -f log_time_anal.awk -vvals="${vals[*]}"
    else
    vals=($total)
    $cat $file | sort  |  awk -f log_time_anal.awk -vvals="${vals[*]}"
    fi
    echo -e
    echo -en "是否繼續? :\n"
    echo "繼續請按enter，退出請按q"

    read process
    if [ "$process" == "q" ]; then
        echo "退出"
        exit
    fi
done