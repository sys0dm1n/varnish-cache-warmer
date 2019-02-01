# varnish-cache-warmer
This is a bash script that uses wget and curl to warm up Varnish by targeting the sitemap.xml of the website

Requirements
------------
It uses wget and curl packages and the website should have a sitemap.xml to work.


Executing the script
----------------------
You can pass as many URLs or IP as you want to the script like this:

    $ sudo chmod +x varnish-cache-warmer.sh
    $ ./varnish-cache-warmer.sh example1.com example2.com example3.com
