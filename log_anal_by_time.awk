BEGIN {
    split(vals,val, " ");
    first_time="";
    final_time="";
    specific_time=val[1]" "val[2]
}
{
    first_time=$4" "$5
    final_time=$7" "$8
    if (first_time <= specific_time && specific_time <= final_time){
        print $0
    }
}