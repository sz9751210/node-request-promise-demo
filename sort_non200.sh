#!/bin/bash


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
        cat="gunzip -c"
    else
        cat="cat"
    fi

    echo '---------------------------------- statusCode非200狀態 ----------------------------------'
    eval $cat $file | sort -n -r | grep -v "statusCode: 200"
    echo -e
    echo -en "是否繼續? :\n"
    echo "繼續請按enter，退出請按q"

    read process
    if [ "$process" == "q" ]; then
        echo "退出"
        exit
    fi
done