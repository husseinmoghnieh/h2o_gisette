#!/usr/bin/env bash
mvn clean
mvn install:install-file -Dfile=./localjars/h2o-genmodel.jar -DgroupId=water -DartifactId=h2o-genmodel -Dversion=3.0 -Dpackaging=jar
mvn package
mvn exec:java -Dexec.mainClass="pojo.PredictMain"
