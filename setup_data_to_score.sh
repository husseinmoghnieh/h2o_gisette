#!/usr/bin/env bash

hadoop_url="ch2-master.citation.io"

#train data no label
hadoop fs -rm -r hdfs://${hadoop_url}:/user/root/GisetteScoreTest
hadoop fs -mkdir hdfs://${hadoop_url}:/user/root/GisetteScoreTest
hadoop fs -put ./data/gisette_train.data  hdfs://${hadoop_url}:/user/root/GisetteScoreTest/.

#label
hadoop fs -rm -r hdfs://${hadoop_url}:/user/root/GisetteScoreTestLabels
hadoop fs -mkdir hdfs://${hadoop_url}:/user/root/GisetteScoreTestLabels
hadoop fs -put ./data/gisette_train.labels  hdfs://${hadoop_url}:/user/root/GisetteScoreTestLabels/.



hadoop fs -rm -r hdfs://${hadoop_url}:/user/root/GisetteScoreTestSmall
hadoop fs -mkdir hdfs://${hadoop_url}:/user/root/GisetteScoreTestSmall
hadoop fs -put ./data/gisette_train_small_header.data  hdfs://${hadoop_url}:/user/root/GisetteScoreTestSmall/.
