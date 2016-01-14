#!/usr/bin/env bash

hadoop_url="ch1.citation.io"
hadoop fs -rm -r hdfs://${hadoop_url}:/user/root/GisetteScoreTest
hadoop fs -put ./data/gisette_train.data  hdfs://${hadoop_url}:/user/root/GisetteScoreTest/.
