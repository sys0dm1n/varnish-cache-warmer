#!/bin/bash
#
# Written by AC - 2015 <contact@chemaly.com> - sys0dm1n.com
#
# The URLs or IPs variables are passed as an argument to the script like below:
# ./varnish-cache-warmer.sh example1.com example2.com example3.com

warm_varnish() {
    for i in "$@"
    do
        echo "Warming cache for $i"
        wget --quiet http://$i/sitemap.xml --no-cache --output-document - | egrep -o "http(s?)://$i[^ \"\'()\<>]+" | while read line; do
            if [[ $line == *.xml ]]
            then
                newURL=$line
                wget --quiet $newURL --no-cache --output-document - | egrep -o "http(s?)://$i[^ \"\'()\<>]+" | while read newline; do
                    time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
                    echo $newline
                done
            else
                time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
                echo $line
            fi
        done
    echo "Done warming cache for $i"
    done
}

for host in "${URL[@]}"; do
    warm_varnish $host
done
