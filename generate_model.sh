#!/usr/bin/env bash
Rscript script.R
os_name=uname
if (${os_name} == 'Linux')
    sed -i -e '1ipackage ai.h2o.hive.udf\' ./tmp/GBMModel.java
endif
cp ./tmp/*.java ./src/main/java/ai/h2o/hive/udf/
cp ./tmp/*.jar ./localjars/
cp ./tmp/*.csv ./src/main/resources/
