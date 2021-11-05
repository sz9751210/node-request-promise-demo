BEGIN {
    split(vals,val, " ");
    total=val[1];
    count=0;
    ip="";
    before_ip="";
    first_time="";
    final_time="";
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
            print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
	    first_time=$1" "$2
            final_time=first_time
            before_ip=ip
            count=1;
        }
    } else if (NR==total){
        ip=a[1]
        if (before_ip==ip) {
	    final_time=$1" "$2
            count=count+1;
            print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
        } else {
            print "Time interval : "first_time" - "final_time", IP : "before_ip", count : "count;
	    final_time=$1" "$2
            first_time=final_time
            count=1;
            print "Time interval : "first_time" - "final_time", IP : "ip", count : "count;
        }
    }
}