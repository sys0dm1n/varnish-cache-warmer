# varnish-cache-warmer
This is a bash script that uses wget and curl to warm up Varnish by targeting the sitemap.xml of the website

Requirements
------------
It uses wget and curl packages and the website should have a sitemap.xml to work.


Executing the script:
----------------------
Edit the varnish-cache-warmer.sh and replace website.com by your website.

    # chmod +x varnish-cache-warmer.sh
    # ./varnish-cache-warmer.sh
