#!/bin/bash

# USAGE: email_extractor.sh website_list.txt
# website_list.txt file contains all URLs to extract mail ids.
clear
figlet "     E-extractor"
echo -e "\e[93m By : webcipher101\e[0m"
echo
echo -e "\e[92m Usage : email_extractor.sh website_list.txt \e[0m"
echo -e "\e[37m (+) Please Wait For Some Time ..!!\e[0m"
filename="$1"
while read -r find_url
do
    name="$find_url"
    lynx -dump $find_url | grep "http" >> url1.txt
done < "$filename"
cat url1.txt | awk '{print $2}' > url2.txt
sort url2.txt | uniq -u > urls.txt
rm url1.txt url2.txt
echo -e "\e[37m (+) Extraction of URLs == done..!!"
sleep 5
mode=1
if [ "$mode" -eq "1" ];then
echo -e "\e[37m (+) Be patient, It will take some time\e[0m"
sleep 5
cat urls.txt | while read url
do
echo $url
curl $url > url_text.txt
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" url_text.txt >> mailids.txt
done
fi

sort mailids.txt | uniq >> extracted_mail_list.txt
rm mailids.txt url_text.txt
sleep 5
echo -e "\e[92m (+) Email ids extraction done. Check extracted_mail_list.txt file\e[0m"
sleep 3
exit 0

# End of script
