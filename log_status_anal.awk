BEGIN {
    split(vals,val, " ");
    total=val[1];
    count=0;
    status_code="";
    before_status_code="";
    first_time="";
    final_time="";
    if (val[2] != "") {
        specific_time=val[2]" "val[3]
    } else {
        specific_time=""
    }
}
{
    split($16,a,"\r")
    if (NR==1) {
        before_status_code=a[1]
        first_time=$1" "$2
        final_time=first_time
        count=count+1;
    } else if (NR > 1 && NR < total){
        status_code=a[1]
        if (before_status_code==status_code) {
            final_time=$1" "$2
            count=count+1;
        } else {
            if (!specific_time) {
                print "Time interval : "first_time" - "final_time", status Code : "before_status_code", count : "count;
                final_time=$1" "$2
                before_status_code=status_code
                first_time=$1" "$2
                count=1;
            } else {
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", status Code : "before_status_code;
                    exit
                } else {
                    before_status_code=status_code
                    first_time=$1" "$2
                }
            }
        }
    } else if (NR==total){
        status_code=a[1]
        if (!specific_time) {
            if (before_status_code==status_code) {
                final_time=$1" "$2
                count=count+1;
                print "Time interval : "first_time" - "final_time", status Code : "before_status_code", count : "count;
            } else {
                print "Time interval : "first_time" - "final_time", status Code : "before_status_code", count : "count;
                first_time=$1" "$2
                final_time=$1" "$2
                count=1;
                print "Time interval : "first_time" - "final_time", status Code : "status_code", count : "count;
            }
        } else {
            if (before_status_code==status_code) {
                final_time=$1" "$2
                count=count+1;
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", status Code : "before_status_code;
                }
            } else {
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", status Code : "before_status_code;
                } else {
                    first_time=$1" "$2
                    final_time=first_time
                    print "Time interval : "first_time" - "final_time", status Code : "status_code;
                }
            }
        }
    }
}