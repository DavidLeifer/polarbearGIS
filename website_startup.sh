#! /bin/bash
apt-get update
apt-get install apache2 -y
a2ensite default-ssl
a2enmod ssl
vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
echo "Page served from: $vm_hostname" | \
tee /var/www/html/index.html

sudo apt-get install unzip
sudo apt-get install wget
y
--sk

#polar_landing
#https://drive.google.com/file/d/1BmEveFAfZtponioIzz37gPWyckJk-uFy/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1BmEveFAfZtponioIzz37gPWyckJk-uFy' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1BmEveFAfZtponioIzz37gPWyckJk-uFy" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

cd polar_landing
sudo mv index.html /var/www/html
sudo mv index.js /var/www/html
sudo mv index.scss /var/www/html
cd ..
sudo mkdir images
cd polar_landing
cd images
sudo mv fart.png /var/www/html/images
sudo mv Part2Section2.png /var/www/html/images
sudo mv ppt_cor.png /var/www/html/images
sudo mv temp_cor.png /var/www/html/images
cd ..
cd ..
sudo rm -R polar_landing

#ppt_cor_xyz.zip
#https://drive.google.com/file/d/1gk20RXafRluaVIZ473SgLp0N-YfFjAKn/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gk20RXafRluaVIZ473SgLp0N-YfFjAKn' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1gk20RXafRluaVIZ473SgLp0N-YfFjAKn" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#tmean_bil2tif_LaElNeu_analysis_xyz
#https://drive.google.com/file/d/1kjvAl3BRLuD6fNSOftoqDHZRjOqjbyDk/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1kjvAl3BRLuD6fNSOftoqDHZRjOqjbyDk' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1kjvAl3BRLuD6fNSOftoqDHZRjOqjbyDk" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#ppt_bil2tif_LaElNeu_analysis_xyz
#https://drive.google.com/file/d/17W2rT_OMYgCq9w8T66By9los9m_y8ITb/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=17W2rT_OMYgCq9w8T66By9los9m_y8ITb' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=17W2rT_OMYgCq9w8T66By9los9m_y8ITb" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#tmean_cor_xyz
#https://drive.google.com/file/d/1c-ZPMmlcGAxfWLKP5QxPgrVDuMZOiT69/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1c-ZPMmlcGAxfWLKP5QxPgrVDuMZOiT69' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1c-ZPMmlcGAxfWLKP5QxPgrVDuMZOiT69" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#pandamoniumGIS_part2Section2
#https://drive.google.com/file/d/1xhjlLrUmNjDqGqZQuKIbqytHcB2usbEW/view?usp=sharing
sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1xhjlLrUmNjDqGqZQuKIbqytHcB2usbEW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1xhjlLrUmNjDqGqZQuKIbqytHcB2usbEW" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data


#pandamoniumGIS20210110_tmeanbuild-dist
https://drive.google.com/file/d/1k1WrXHWL2Z5ZBKmUqZg3zuaVOAI_qS7w/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1k1WrXHWL2Z5ZBKmUqZg3zuaVOAI_qS7w' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1k1WrXHWL2Z5ZBKmUqZg3zuaVOAI_qS7w" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#polarbearGIS-dist
https://drive.google.com/file/d/1x2Ab2y4a15MeVmluK6LVzIqhC1AbkL2W/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1x2Ab2y4a15MeVmluK6LVzIqhC1AbkL2W' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1x2Ab2y4a15MeVmluK6LVzIqhC1AbkL2W" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data





