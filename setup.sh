#!/bin/bash

. vars.sh

## Apt
apt-get update
apt-get install -y wget locales
echo -e "en_US.UTF-8 UTF-8\nsv_SE.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.utf8 && /usr/sbin/update-locale LANG=en_US.UTF-8

## CRAN R
apt-get install -y dirmngr
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
echo deb http://ftp.acc.umu.se/mirror/CRAN/bin/linux/ubuntu artful/ >> /etc/apt/sources.list
apt update
apt-get install -y r-base
#R --slave -e 'install.packages("rmarkdown", repos="https://ftp.acc.umu.se/mirror/CRAN/")'

## Rstudio
wget -nc $rstudio_url
yes | apt install libxslt1-dev ./$(basename $rstudio_url)
### FIXME
#echo 'export QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb' >>$SINGULARITY_ENVIRONMENT

## Ricopili
apt-get -y install texlive
wget -nc $ricopili_url
tar xf $(basename $ricopili_url)
mv rp_bin /opt/
chmod 755 /opt/rp_bin
cd /opt/rp_bin
### FIXME
#export PATH=${PATH:+$PATH:}/opt/rp_bin:/usr/rp_bin/pdfjam
#echo 'export PATH=${PATH:+$PATH:}/opt/rp_bin:/opt/rp_bin/pdfjam' >>$SINGULARITY_ENVIRONMENT
#echo 8 | rp_config
cd -

## liftOver
wget -nc $liftover_url
chmod 755 liftOver
mv liftOver /usr/bin/liftOver

## Metal
wget -nc $metal_url
tar xf $(basename $metal_url)
mv generic-metal /opt/metal
chmod 755 /opt/metal
ln -s /opt/metal/metal /usr/bin/

## SHAPEIT
wget -nc $shapeit_url
tar xf $(basename $shapeit_url)
chmod 755 $shapeit_name
mv $shapeit_name /opt
ln -s /opt/$shapeit_name/bin/shapeit /usr/bin/

## IMPUTE2
wget -nc $impute_url
tar xf $(basename $impute_url)
impute_name=$(basename $impute_url .tgz)
chmod 755 $impute_name
mv $impute_name /opt/
ln -s /opt/$impute_name/impute2 /usr/bin/

## PLINK
apt-get install -y unzip
wget -nc $plink_url
unzip -d /opt/plink/ $(basename $plink_url)
ln -s /opt/plink/plink /usr/bin/
ln -s /opt/plink/prettify /usr/bin/

## EIGENSOFT
eigensoft_version=$(basename $eigensoft_url .tar.gz)
eigensoft_version=${eigensoft_version#v}
apt-get install -y build-essential libopenblas-dev liblapacke-dev libgsl-dev
wget -nc $eigensoft_url
tar xf $(basename $eigensoft_url)
cd "EIG-$eigensoft_version/src"
make clobber
make install LDLIBS="-llapacke"
cd -
mv "EIG-$eigensoft_version" /opt/
### FIXME
#echo 'export PATH=${PATH:+$PATH:}/opt/'"EIG-$version"'/bin' >>$SINGULARITY_ENVIRONMENT

## EAGLE
wget -nc $eagle_url
tar xf $(basename $eagle_url)
eagle_name=$(basename $eagle_url .tar.gz)
chmod 755 $eagle_name
mv $eagle_name /opt/
ln -s /opt/$eagle_name/eagle /usr/bin/

## Good practice to update library path
ldconfig

## Delete all the apt list files since they're big
rm -rf /var/lib/apt/lists/*
