# sed -En 's/.*"Server":"?([^,"]*)"?.*/\1/p'
# grep -zoP '"Server":"\K[^"]+' | \
    #    sed -n 's|.*"Server":"\([^"]*\)".*|\1|p' | \

KEY=Server
IN=CC-MAIN-20170116095121-00570-ip-10-171-10-70.ec2.internal.warc.wat.gz
IN=yo.wat

cat $IN | \
    grep -F '"Server' | \
    parallel -j ${1-6} --pipe --linebuffer --block 10M ./wat2 $KEY \| \
    tr -d \'\"\' \| \
    tr [:upper:] [:lower:] | \
    ../a.out | \
    head

