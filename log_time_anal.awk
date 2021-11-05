BEGIN {
    split(vals,val, " ");
    total=val[1];
    count=0;
    ip="";
    before_ip="";
    first_time="";
    final_time="";
    if (val[2] != "") {
        specific_time=val[2]" "val[3]
    } else {
        specific_time=""
    }
}
{
    split($(NF),a,"\r")
    if (NR==1) {
        before_ip=a[1]
        first_time=$1" "$2
        final_time=first_time
        count=count+1;
    } else if (NR > 1 && NR < total){
        ip=a[1]
        if (before_ip==ip) {
            final_time=$1" "$2
            count=count+1;
        } else {
            if (!specific_time) {
                print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
                final_time=$1" "$2
                before_ip=ip
                first_time=$1" "$2
                count=1;
            } else {
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", IP : "before_ip;
                    exit
                } else {
                    before_ip=ip
                    first_time=$1" "$2
                }
            }
        }
    } else if (NR==total){
        ip=a[1]
        if (!specific_time) {
            if (before_ip==ip) {
                final_time=$1" "$2
                count=count+1;
                print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
            } else {
                print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
                first_time=$1" "$2
                final_time=$1" "$2
                count=1;
                print "Time interval : "first_time" - "final_time", IP : "ip", count : "count;
            }
        } else {
            if (before_ip==ip) {
                final_time=$1" "$2
                count=count+1;
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", IP : "before_ip;
                }
            } else {
                if (specific_time >= first_time && specific_time <= final_time) {
                    print "Time interval : "first_time" - "final_time", IP : "before_ip;
                } else {
                    first_time=$1" "$2
                    final_time=first_time
                    print "Time interval : "first_time" - "final_time", IP : "ip;
                }
            }
        }
    }
}