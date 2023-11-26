set -e
wget 'https://iscd.huma-num.fr/media/syndoc.zip' --output-document syndoc.zip
unzip syndoc.zip && rm syndoc.zip
mv syndoc datasets/
wget 'https://iscd.huma-num.fr/media/vhs.zip' --output-document vhs.zip
unzip vhs.zip && rm vhs.zip
mv vhs datasets/