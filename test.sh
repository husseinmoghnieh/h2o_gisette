#!/usr/bin/env bash
os_name=sudo uname
echo ${os_name}
if %os_name% == "Linux"
then
    sed -i -e '1ipackage ai.h2o.hive.udf\' ./tmp/GBMModel.java
else
    echo "please set package in GBMModel manually"
fi