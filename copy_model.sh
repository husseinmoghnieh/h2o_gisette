#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sed -i -e '1ipackage ai.h2o.hive.udf;\' ./tmp/GBMModel.java
        echo "GBMmodel package upadted"
fi
cp ./tmp/*.java ./src/main/java/ai/h2o/hive/udf/
cp ./tmp/*.jar ./localjars/
