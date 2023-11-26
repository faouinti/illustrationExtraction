set -e
wget 'https://iscd.huma-num.fr/media/models.zip' --output-document models.zip
unzip models.zip && rm models.zip
mv models models/