#!/bin/bash

#THIS SCRIPT ASSUMES MONERO_ROOT IS SET#####

checkout=$1
mode=$2
repo=$3
TMP=/tmp/
OWD=`pwd`


if [[ -z "$checkout" ]]; then
	echo "Failure no checkout id";
	exit 1;
fi

if [[ -z "$mode" ]]; then
	echo "no mode";
	exit 1;
fi
if [[ "$mode" == "remote" ]]; then
	if [[ -z "$repo" ]]; then
		echo "remote mode missing repo";
		exit 1;
	fi
	git_root=$3;
fi

if [[ "$mode" == "local" ]]; then
	git_root=`git rev-parse --show-toplevel`;
fi


project_name=`echo $git_root | awk -F '/' '{print $NF}'`
TMP=$TMP"`date --iso-8601=seconds`-"$project_name
mkdir -p $TMP
cd $TMP
git clone $git_root
cd $project_name
git checkout $checkout
make release
release=$?
rm -rf build
make
debug=$?

cd $OWD
rm -rf $TMP

if [[ $debug -eq 0 ]]  && [[ $release -eq 0 ]]; then
	exit 0;
else
	exit 1;
fi


