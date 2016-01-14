#!/usr/bin/env bash
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "GBMmodel package upadted"
elif [[ "$OSTYPE" == "darwin14" ]]; then
	echo "Please set manually the package name in GBModel.java"
fi
