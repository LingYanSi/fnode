# 先关文档 https://zhuanlan.zhihu.com/p/27308276
# 
fontColor='black:30;red:31;green:32;yellow:33;blue:34;megenta:35;cyan:36;white:37;'
# fontColorLight='black:90;red:91;green:92;yellow:99;blue:94;megenta:95;cyan:96;white:97;'
bgdColor='black:40;red:41;green:42;yellow:44;blue:44;megenta:45;cyan:46;white:47;'
# bgdColorLight='black:100;red:101;green:102;yellow:1010;blue:1010;megenta:105;cyan:106;white:107;'
style='bold:1;dim:2;italic:3;underline:4;inverse:7;hidden:8;strikethrough:9;'

getColor(){
    if [[ $1 && $2 ]]; then
        # num=`echo $1 | sed 's/;/\n/g' | grep $2`
        num=`echo $1 | tr ";" "\n" | grep $2 | grep -Eo '[0-9]+'`
        echo $num
    else
        echo ""
    fi
}

getStyle(){
    v=`echo $1 | tr ";" "\n" | grep $2 | awk 'END {print}' | awk -F: '{print $2}'`
    num=`getColor $3 $v`
    echo $num
}

cEcho(){
    # 移除空格
    ss=`echo $2 | sed -E 's/ //g'`
    c=`getStyle $ss "color" $fontColor`
    bgd=`getStyle $ss "bgd" $bgdColor`
    st=`getStyle $ss "style" $style`
    #
    str=`echo "$st;$c;$bgd;" | sed -E 's/;+$|^;+//g' |  sed -E 's/;+/;/g'`

    echo -e "\033[${str}m$1\033[0m"
}

# color "nidaye" "color: white; bgd: cyan; style: italic"
