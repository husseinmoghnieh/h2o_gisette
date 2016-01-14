#!/usr/bin/env bash
mvn compile
mvn package
hive -f hive_score.sql