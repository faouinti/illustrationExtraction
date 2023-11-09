set -e
wget 'https://iscd.huma-num.fr/media/syndoc.zip' --output-document syndoc.zip
unzip syndoc.zip && rm syndoc.zip
mv syndoc ../datasets/