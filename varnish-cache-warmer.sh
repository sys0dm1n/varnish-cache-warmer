#!/bin/bash
#
# Written by AC - 2015 <al@terraltech.com> - sys0dm1n.com
#
URL='website.com'

wget --quiet http://$URL/sitemap.xml --no-cache --output-document - | egrep -o "http(s?)://$URL[^ \"\'()\<>]+" | while read line; do
    if [[ $line == *.xml ]]
    then
        newURL=$line
        wget --quiet $newURL --no-cache --output-document - | egrep -o "http(s?)://$URL[^ \"\'()\<>]+" | while read newline; do
           time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $newline -o /dev/null 2>&1
           echo $newline
         done
    else
         time curl -A 'Cache Warmer' -sL -w "%{http_code} %{url_effective}\n" $line -o /dev/null 2>&1
         echo $line
     fi
done
