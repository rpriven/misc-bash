#!/bin/bash

# CTF Recon // CTFBuster // Djedi ReconBox
# See below for bugBuster
# Works best on a single machine

## To Do list

# if cidr, modify options for each scan for cidr instead of ip
# if url:port format, separate port and add to parameters
# if no results found: don't create a log file
# httprobe: for each url make sure it is up?
# if 80/443: feroxbuster bruteforce dirs, gowitness screenshots
# gowitness: for each bruteforced dir, take screenshot
# webanalyze: make sure url format is correct
# feroxbuster: make sure url format is correct
# threading: will '&' be enough? or maybe try python
# Python: rewrite code to run in python to make it easier

url=$1
# if not sudo, exit
if ! [ $(id -u) = 0 ]; then
    echo "Please run as root"
    exit 1
fi
if [ ! -d "$url/recon/" ]; then
    mkdir $url/recon
fi

# Find Host
# naabu -host 192.168.226.0/24

# Port Scanning
naabu -host $url -nmap-cli 'nmap -sS -p- -oN recon/nmap.all_ports'
naabu -host $url -nmap-cli 'nmap -sV -sC -A -vv -oN recon/nmap.init'
naabu -host $url -nmap-cli 'sudo nmap --script vuln -oN recon/nmap.vuln'
# Pull CVEs
cat recon/nmap.vuln | nl | grep -oE CVE-\[0-9]{4}-\[0-9]{4}\+ | sort -u >> $url/recon/cves_found.txt
# Check encryption
if [ $(cat recon/nmap.*) | grep '443' ]; then
    nmap --script ssl-enum-ciphers -p 443 $url -oN recon/nmap.ssl
fi

# or
# rustscan -a $url -- -A -sC | tee $url/recon/rustscan
docker run -it --rm --name rustscan rustscan/rustscan:2.0.1 -a $url -- -A -sC | tee recon/rustscan



# if smb (139/445), enum4linux
enum4linux -a $url | tee recon/enum4linux

# if 80,443,8080, run nuclei, nikto, webanalyze, feroxbuster
# nuclei -u (single url) or -l (list)
nuclei -u $url | tee recon/nuclei
echo "[@] Nikto Scanning..."
# nikto url: http://127.0.0.1:3000
nikto -h $url | tee recon/nikto
# webanalyze url: http://127.0.0.1:3000
webanalyze -update
webanalyze -host $url -crawl 2 -output csv > recon/webanalyze
rm technologies.json
ffuf -u http://$url/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ

# Feroxbuster is awesome, but probably too much for small sites
# feroxbuster url: http://127.0.0.1:3000
feroxbuster -u http://$url -x pdf,js,html,php,txt,json,docx,sh,py,cgi,css,md,bak,kdbx,exe,url,yml,toml,public,private,log,asa,inc,zip,tar,gz,tgz,rar,java,doc,rtf,xls,ppt,old -t 1000
# tee | recon/feroxbuster (always makes output not look good)

# Check SecurityHeaders.io (or .com)
curl -L https://securityheaders.com/?q=$url&followRedirects=on >> security_headers.io | grep -A 10 "Missing Headers" >> missing_headers.txt
# or -F(ull pages) and custom -P(ath)
gowitness -F https://securityheaders.com/?q=$url&followRedirects=on -P $url/recon/screenshots/
# gowitness: robots.txt, ...


if [ $(cat nmap.vuln | grep -E 'php|PHP') ]
    sqlmap -u http://$url/ --data "id=&password=" --random-agent --batch -dbs
fi


# consider redoing as this doesn't find anything ever
# while read line; do
#     searchsploit $line >> $url/recon/vulns.txt;
# done < cves.txt

# Remove scan results files if they are empty
sudo find $url/recon -type f -empty -delete


# gobuster dir -u $url -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,sh,txt,cgi,html,js,css,py,md,pdf | tee recon/gobuster &




####  Bug Bounty Recon  ####

# Nuclei
# waymore
# hakrawler
# gospider
# xnLinkFinder
# HUNT



# waymore
# get all urls from wayback (no commone crawl or alienvault because 
# of [-xcc and -xav]), save first 1000 results from 2015 forward
python3 waymore.py -i $url -f -xcc -xav -xus -l 1000 -from 2015
# or cat subdomains_list.txt | python3 waymore.py

# Parse js files for links that aren't live anymore but still exist
# xnLinkFinder & waymore
# python3 xnLinkFinder -i ~/Tools/waymore/results/redbull.com -sp https://www.redbull.com -sf redbull.com -o redbull.txt