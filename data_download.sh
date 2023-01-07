#!/usr/bin/env bash

# Stop if anything unusual happens
set -euo pipefail

# Define file URLs
FILEURL_01DL="https://archive.ics.uci.edu/ml/machine-learning-databases/00602/DryBeanDataset.zip"
FILEURL_02DD="https://raw.githubusercontent.com/alexdepremia/Unsupervised-Learning-Datasets/main/data_kPCA_2022-2023.txt"
FILEURL_02LL="https://raw.githubusercontent.com/alexdepremia/Unsupervised-Learning-Datasets/main/labels_kPCA_2022-2023.txt"

# A useful unattended download function :)
function loopydl
{
    while [ 1 ]; do
        wget --retry-connrefused --waitretry=1 --read-timeout=10 --timeout=10 --tries=0 --continue $1
        if [ $? = 0 ]; then break; fi;
        sleep 1s;
done;
}

# Functionalized aliases
function cprf
{
    cp -R -f $1 $2
}
function rmrf
{
    rm -R -f $1
}

# Do everything in a dedicated folder (to be wiped afterwards)
mkdir -p ./data/scratch/
cd ./data/scratch/


# Download data
loopydl $FILEURL_01DL
loopydl $FILEURL_02DD
loopydl $FILEURL_02LL

# Unzip what's zipped
unzip ./DryBeanDataset.zip

# Copy-back relevant files
cprf ./DryBeanDataset/Dry_Bean_Dataset.xlsx ../DryBeansDL.xslx
cprf ./data_kPCA_2022-2023.txt ../kPCADD.txt
cprf ./labels_kPCA_2022-2023.txt ../kPCALL.txt

# Wipe garbage
cd ..
rmrf ./scratch/
cd ..
