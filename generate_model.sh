#!/usr/bin/env bash
Rscript script.R
cp ./tmp/*.java ./src/main/java/ai/h2o/hive/udf/
cp ./tmp/*.jar ./localjars/
cp ./tmp/*.csv ./src/main/resources/


