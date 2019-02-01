#!/bin/bash
#
# Written by AC - 2015 <al@terraltech.com> - sys0dm1n.com
#
# The URL variable can be a list of 1 or more domains and IPs
# When using more than 1 host, make sure to seperate
# the different hosts by a space character
# For example: URL=('example.com' '127.0.0.1')
#                    or: URL=('example.com')
#                    or: URL=('127.0.0.1')
URL=('website.com')

warm_varnish() {
    echo "Warming cache for $1"
    wget --quiet http://$1/sitemap.xml --no-cache --output-document - | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read line; do
        if [[ $line == *.xml ]]
        then
            newURL=$line
            wget --quiet $newURL --no-cache --output-document - | egrep -o "http(s?)://$1[^ \"\'()\<>]+" | while read newline; do
                time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
                echo $newline
            done
        else
            time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
            echo $line
        fi
    done
    echo "Done warming cache for $1"
}

for host in "${URL[@]}"; do
    warm_varnish $host
done
