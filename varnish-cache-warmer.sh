#!/bin/bash
#
# Written by AC - 2015 <contact@chemaly.com> - sys0dm1n.com
#
# The URLs or IPs variables are passed as an argument to the script like below:
# ./varnish-cache-warmer.sh example1.com example2.com example3.com

VERSION='1.0.0'
USER_AGENT="VarnishCacheWarmer/$VERSION (see https://github.com/sys0dm1n/varnish-cache-warmer)"

warm_varnish() {
    echo "Warming cache for $1"
    curl -sL -A "$USER_AGENT" http://$1/sitemap.xml | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read line; do
        if [[ $line == *.xml ]]
        then
            newURL=$line
            curl -sL -A "$USER_AGENT" $newURL | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read newline; do
                time curl -sL -A "$USER_AGENT" -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
                echo $newline
            done
        else
            time curl -sL -A "$USER_AGENT" -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
            echo $line
        fi
    done
    echo "Done warming cache for $1"
}

for host in "$@"; do
    warm_varnish $host
done
