#!/usr/bin/env bash
Rscript script.R
cp ./tmp/*.java ./src/main/java/ai/h2o/hive/udf/

cp ./tmp/*.jar ./localjars/

#mvn install:install-file -Dfile=./tmp/h2o-genmodel.jar -DgroupId=hex.h2o -DartifactId=genmodel -Dversion=1.0 -Dpackaging=jar
#mvn clean install
#mvn exec:java -Dexec.mainClass="PredictMain"


