#!/bin/bash

# 列出檔案
# Files=($(ls -td ./logs/*))
# 定義要找的類型
Status=('wait' 'dns' 'tcp' 'firstByte' 'download' 'total' 'all')

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


    # 輸入要找的類型編號
    echo -en "請輸入要查看最慢的選項 :\n"
    for key in ${!Status[@]}; do
        echo "$key ${Status[$key]}"
    done

    read status_num

    if [ $status_num == "q" ]; then
        echo "退出"
        break
    fi

    status=${Status[status_num]}

    # 輸入要找的筆數
    echo -en "請輸入要查看的前N筆 :\n"

    read top

    if [ $top == "q" ]; then
        echo "退出"
        break
    fi

    # 判斷狀態
    if [[ $status_num -eq 0 ]]; then
        var=4

    elif [[ $status_num -eq 1 ]]; then
        var=6

    elif [[ $status_num -eq 2 ]]; then
        var=8

    elif [[ $status_num -eq 3 ]]; then
        var=10

    elif [[ $status_num -eq 4 ]]; then
        var=12

    elif [[ $status_num -eq 5 ]]; then
        var=14

    elif [[ $status_num -eq 6 ]]; then
        t=4
        for ((i = 0; i < ${#Status[*]} - 1; i++)); do
            echo '---------------------------------- '${Status[$i]}' ----------------------------------'
            eval $cat $file | sort -n -r -k $t  | head -n $top
            ((t = t + 2))
        done

    else
        echo "請重新執行"
    fi

    if [[ $status_num =~ ^[0-5]$ ]]; then
        echo '----------------------------------'${status}' ----------------------------------'
        eval $cat $file | sort -n -r -k $var | head -n $top
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