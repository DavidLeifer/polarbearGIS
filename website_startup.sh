#! /bin/bash
#https://medium.com/@shivamgrg38/setting-up-http-to-https-and-non-www-to-www-redirects-for-external-http-s-load-balancers-on-b73be558eab5
#https://stackoverflow.com/questions/35311697/google-cloud-http-load-balancer-cant-connect-to-my-instance
apt-get update
apt-get install apache2 -y
a2ensite default-ssl
a2enmod ssl
vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
echo "Page served from: $vm_hostname" | \
tee /var/www/html/index.html

sudo apt-get install unzip
sudo apt-get install wget -y

cd /var/www/html/
sudo rm index.html

#polar_landing
#https://drive.google.com/file/d/1BmEveFAfZtponioIzz37gPWyckJk-uFy/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1BmEveFAfZtponioIzz37gPWyckJk-uFy' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1BmEveFAfZtponioIzz37gPWyckJk-uFy" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

cd polar_landing
sudo mv index.html /var/www/html
sudo mv index.js /var/www/html
sudo mv index.scss /var/www/html
cd ..
sudo mkdir images
cd polar_landing
cd images
sudo mv Part2Section2.png /var/www/html/images
sudo mv ppt_cor.png /var/www/html/images
sudo mv temp_cor.png /var/www/html/images
sudo mv polar_radar.png /var/www/html/images
sudo mv difference-image.png /var/www/html/images
cd ..
cd ..
sudo rm -R polar_landing

#ppt_cor_xyz.zip
#https://drive.google.com/file/d/1gk20RXafRluaVIZ473SgLp0N-YfFjAKn/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gk20RXafRluaVIZ473SgLp0N-YfFjAKn' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1gk20RXafRluaVIZ473SgLp0N-YfFjAKn" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#ppt_bil2tif_resize_xyz.zip
#https://drive.google.com/file/d/15O_zc0sBq21aPrnc9DHt9H62ZnFKUmEV/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=15O_zc0sBq21aPrnc9DHt9H62ZnFKUmEV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=15O_zc0sBq21aPrnc9DHt9H62ZnFKUmEV" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#tmean_bil2tif_resize_xyz.zip
#https://drive.google.com/file/d/1r44Tts5Grp5nFbJBQJdBNi7-G7Z2fvHz/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1r44Tts5Grp5nFbJBQJdBNi7-G7Z2fvHz' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1r44Tts5Grp5nFbJBQJdBNi7-G7Z2fvHz" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

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

#tha_difference
#https://drive.google.com/file/d/1RXQRf90naDhu2wYmoNSrCDIctVa9GD8x/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1RXQRf90naDhu2wYmoNSrCDIctVa9GD8x' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1RXQRf90naDhu2wYmoNSrCDIctVa9GD8x" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#tha_difference-dist
#https://drive.google.com/file/d/1iSGmmZ7Aoi10EJMO5RzCx5Cogow5ZXl6/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1iSGmmZ7Aoi10EJMO5RzCx5Cogow5ZXl6' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1iSGmmZ7Aoi10EJMO5RzCx5Cogow5ZXl6" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#pandamoniumGIS_part2Section2-dist
#https://drive.google.com/file/d/1J_-rP0xNeRxEdCFxCTyEYNLdoKT7UzUV/view?usp=sharing
sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1J_-rP0xNeRxEdCFxCTyEYNLdoKT7UzUV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1J_-rP0xNeRxEdCFxCTyEYNLdoKT7UzUV" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#pandamoniumGIS20210110_tmeanbuild
#https://drive.google.com/file/d/1DvyOhuaOx76U9LowPnOSqK7FzhaoEg9s/view?usp=sharing
sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1DvyOhuaOx76U9LowPnOSqK7FzhaoEg9s' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1DvyOhuaOx76U9LowPnOSqK7FzhaoEg9s" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#polarbear-dist
#https://drive.google.com/file/d/1Ej9z0w9i4kVj3CRmzAFxwHMwtQPZne2v/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Ej9z0w9i4kVj3CRmzAFxwHMwtQPZne2v' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Ej9z0w9i4kVj3CRmzAFxwHMwtQPZne2v" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data
sudo mv /var/www/html/polarbear-dist /var/www/html/polarbearGIS

#polar_radar
#https://drive.google.com/file/d/1wCTA1W04c9Wq3mF7oo4cCXG7rVdfqe1F/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1wCTA1W04c9Wq3mF7oo4cCXG7rVdfqe1F' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1wCTA1W04c9Wq3mF7oo4cCXG7rVdfqe1F" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data

#blogs
#https://drive.google.com/file/d/1XpOCrcraIMo8cz8O04chw31Al3_9qHSi/view?usp=sharing

sudo wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1XpOCrcraIMo8cz8O04chw31Al3_9qHSi' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1XpOCrcraIMo8cz8O04chw31Al3_9qHSi" -O xyz-timeseries-data && rm -rf /tmp/cookies.txt

sudo unzip xyz-timeseries-data
sudo rm xyz-timeseries-data
