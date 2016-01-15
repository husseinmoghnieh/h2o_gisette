#!/usr/bin/env bash
Rscript script.R
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sed -i -e '1ipackage ai.h2o.hive.udf;\' ./tmp/GBMModel.java
        echo "GBMmodel package upadted"
elif [[ "$OSTYPE" == "darwin14" ]]; then
	echo "Please set manually the package name in GBModel.java"
fi
cp ./tmp/*.java ./src/main/java/ai/h2o/hive/udf/
cp ./tmp/*.jar ./localjars/
#hadoop fs -copyToLocal hdfs://ch2-master.citation.io/user/root/tmp/ ./src/main/resources/

#cp ./tmp/*.csv ./src/main/resources/
