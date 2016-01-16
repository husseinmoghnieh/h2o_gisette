#!/usr/bin/env bash
hadoop fs -rm   hdfs://ch2-master.citation.io:/user/root/h2o-genmodel.jar
hadoop fs -rm   hdfs://ch2-master.citation.io:/user/root/ScoreGisetteData-1.0-SNAPSHOT.jar
hadoop fs -put localjars/h2o-genmodel.jar  hdfs://ch2-master.citation.io:/user/root/
hadoop fs -put target/ScoreGisetteData-1.0-SNAPSHOT.jar  hdfs://ch2-master.citation.io:/user/root/