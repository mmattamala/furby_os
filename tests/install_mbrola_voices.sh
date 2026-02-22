#!/bin/sh
#
# festivaltts-install.sh
# -----
#
# Installation and setup of a Festival based TTS system.
# Following instructions from:
# - [http://ubuntuforums.org/showthread.php?t=751169]
#

# Make sure all of the preliminary packages are installed on your system with the following command:
sudo apt-get install festival festlex-cmu festlex-poslex festlex-oald libestools1.2 unzip -y
# This installs festival v.2.1.
# A more recent version 2.4 can be downloaded from [http://www.cstr.ed.ac.uk/downloads/festival/2.4/]

# Installing the standard Festvox diphone voices
# These are the voices that are supplied by the Festvox project, which is run by the 
# Carnegie Mellon University speech group. See the voice demo page (kal, ked, don and rab are
# the voices of interest). Of all of the voices we are concerned with, these take up the
# smallest size on disk, and are the only voices currently in the Ubuntu package tree.
# All of the other voices have to be installed manually. However, these are also the poorest
# quality voices and currently, on my computer, they cause festival to segfault (though I
# have used them successfully with other set-ups in the past). YMMV.
# Some of the voices have 8k and 16k versions. This is the output frequency of the audio
# synthesis. The 16k versions have higher quality output and sound better.
# The four English voices are:
# festvox-don
# festvox-rablpc[8|16]k
# festvox-kallpc[8|16]k
# festvox-kdlpc[8|16]k
# To find all the available festvox voices, execute the following command:
apt-cache search festvox-*
# Install italian, american and british voices
sudo apt-get install festvox-italp16k festvox-itapc16k festvox-kallpc16k festvox-kdlpc16k festvox-rablpc16k -y

# Configuring festival
nano ~/.festivalrc

# Installing the enhanced MBROLA voices
# ------
# These voices are provided by the MBROLA project, run by the TCTS Lab of the Faculté
# Polytechnique de Mons in Belgium. They offer several voices, in a variety of languages,
# which sound much better than the Festvox diphone voices.
# The database of voices can be viewed at the project's download page.
# See the voice demo page (the us1, us2 and us3 are the voices of interest).
# To use the MBROLA voices we need three parts:
# (1.) the mbrola binary program that parses a tokenstream the festival program feeds
# it and returns audio data back to festival,
# (2.) the MBROLA voices, and (3.) the Festvox wrappers to let the festival program
# use the voices. This may sound scary, but it's really easy to do.

# We will download everything we need for the English and Italian voices into a temporary
# directory (total download size is approximately twenty megs):
mkdir /tmp/mbrola
cd /tmp/mbrola
wget http://www.tcts.fpms.ac.be/synthesis/mbrola/bin/raspberri_pi/mbrola.tgz
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/us1/us1-980512.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/us2/us2-980812.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/us3/us3-990208.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/en1/en1-980910.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it1/it1-010213.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it2/it2-010406.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it3/it3-010304.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it4/it4-010926.zip
tar -xzvf mbrola.tgz
sudo mv mbrola /usr/bin
rm mbrola.tgz
unzip us1-980512.zip
unzip us2-980812.zip
unzip us3-990208.zip
unzip en1-980910.zip
unzip it1-010213.zip
unzip it2-010406.zip
unzip it3-010304.zip
unzip it4-010926.zip

# Make the directories where the voices will be installed:
sudo mkdir -p /usr/share/festival/voices/english/us1_mbrola/
sudo mkdir -p /usr/share/festival/voices/english/us2_mbrola/
sudo mkdir -p /usr/share/festival/voices/english/us3_mbrola/
sudo mkdir -p /usr/share/festival/voices/english/en1_mbrola/
sudo mkdir -p /usr/share/festival/voices/italian/it1_mbrola/
sudo mkdir -p /usr/share/festival/voices/italian/it2_mbrola/
sudo mkdir -p /usr/share/festival/voices/italian/it3_mbrola/
sudo mkdir -p /usr/share/festival/voices/italian/it4_mbrola/

# Install the voices and wrappers there:
sudo mv us1 /usr/share/festival/voices/english/us1_mbrola/
sudo mv us2 /usr/share/festival/voices/english/us2_mbrola/
sudo mv us3 /usr/share/festival/voices/english/us3_mbrola/
sudo mv en1 /usr/share/festival/voices/english/en1_mbrola/
sudo mv it1 /usr/share/festival/voices/italian/it1_mbrola/
sudo mv it2 /usr/share/festival/voices/italian/it2_mbrola/
sudo mv it3 /usr/share/festival/voices/italian/it3_mbrola/
sudo mv it4 /usr/share/festival/voices/italian/it4_mbrola/

sudo mv festival/lib/voices/english/us1_mbrola/* /usr/share/festival/voices/english/us1_mbrola/
sudo mv festival/lib/voices/english/us2_mbrola/* /usr/share/festival/voices/english/us2_mbrola/
sudo mv festival/lib/voices/english/us3_mbrola/* /usr/share/festival/voices/english/us3_mbrola/

wget http://www.festvox.org/packed/festival/1.96/festvox_us1.tar.gz
tar -xzvf festvox_us1.tar.gz
sudo mv festival/lib/voices/english/us1_mbrola/* /usr/share/festival/voices/english/us1_mbrola/
rm festvox_us1.tar.gz

wget http://www.festvox.org/packed/festival/1.96/festvox_us2.tar.gz
tar -xzvf festvox_us2.tar.gz
sudo mv festival/lib/voices/english/us2_mbrola/* /usr/share/festival/voices/english/us2_mbrola/
rm festvox_us2.tar.gz

wget http://www.festvox.org/packed/festival/1.96/festvox_us3.tar.gz
tar -xzvf festvox_us3.tar.gz
sudo mv festival/lib/voices/english/us3_mbrola/* /usr/share/festival/voices/english/us3_mbrola/
rm festvox_us3.tar.gz

wget http://www.festvox.org/packed/festival/1.95/festvox_en1.tar.gz
tar -xzvf festvox_en1.tar.gz
sudo mv festival/lib/voices/english/en1_mbrola/* /usr/share/festival/voices/english/en1_mbrola/
rm festvox_en1.tar.gz

rm -rf festival

# Installation of italian voices [http://www2.pd.istc.cnr.it/FESTIVAL/home/full_installation.htm]
cd ~
wget http://download.sourceforge.net/project/it-festival/it-festival/2.0/Italian-FESTIVAL-v2.0.zip
mkdir ~/mbrola
cd ~/mbrola
unzip ../Italian-FESTIVAL.zip
cd 2.0
unzip festival_bin.zip
unzip festival_lib.zip
unzip italian_scm.zip
unzip lex_ifd.zip
cd ~/mbrola/2.0/festival/lib/
sudo cp -R * /usr/share/festival/
cd ../..
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it1/it1-010213.zip
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it2/it2-010406.zip

cd ~/mbrola
# lp_mbrola
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it4/it4-010926.zip
unzip it4-010926.zip
sudo mv it4 /usr/share/festival/voices/english/kal_diphone/
sudo ln -s /usr/share/festival/voices/english/kal_diphone/it4 /usr/share/festival/voices/italian/pc_mbrola/it4
sudo ln -s /usr/share/festival/voices/english/kal_diphone/it4 /usr/share/festival/voices/italian/lp_mbrola/it4
wget http://www.pd.istc.cnr.it/festival/ifd/festvox_lp_mbrola.tar.gz
tar -xzvf festvox_lp_mbrola.tar.gz
sudo mkdir /usr/share/festival/voices/italian/lp_mbrola/festvox
sudo cp festival/lib/voices/italian/lp_mbrola/festvox/lp_mbrola.scm /usr/share/festival/voices/italian/lp_mbrola/festvox/


# pc_mbrola
wget http://tcts.fpms.ac.be/synthesis/mbrola/dba/it3/it3-010304.zip
unzip it3-010304.zip
sudo mv it3 /usr/share/festival/voices/english/kal_diphone/
sudo ln -s /usr/share/festival/voices/english/kal_diphone/it3 /usr/share/festival/voices/italian/pc_mbrola/it3
sudo ln -s /usr/share/festival/voices/english/kal_diphone/it3 /usr/share/festival/voices/italian/lp_mbrola/it3
wget http://www.pd.istc.cnr.it/festival/ifd/festvox_pc_mbrola.tar.gz
tar -xzvf festvox_pc_mbrola.tar.gz
sudo mkdir /usr/share/festival/voices/italian/pc_mbrola/festvox
sudo cp festival/lib/voices/italian/pc_mbrola/festvox/pc_mbrola.scm /usr/share/festival/voices/italian/pc_mbrola/festvox/

cd ..
rm -rf mbrola/
