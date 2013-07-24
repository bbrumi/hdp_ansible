#!/bin/sh

#/*
# * Licensed to the Apache Software Foundation (ASF) under one
# * or more contributor license agreements.  See the NOTICE file
# * distributed with this work for additional information
# * regarding copyright ownership.  The ASF licenses this file
# * to you under the Apache License, Version 2.0 (the
# * "License"); you may not use this file except in compliance
# * with the License.  You may obtain a copy of the License at
# *
# *     http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */

cd `dirname ${0}`;

GANGLIA_CONF_DIR=/etc/ganglia/hdp;
GANGLIA_RUNTIME_DIR=/var/run/ganglia/hdp;

# This file contains all the info about each Ganglia Cluster in our Grid.
GANGLIA_CLUSTERS_CONF_FILE=./gangliaClusters.conf;

function createDirectory()
{
    directoryPath=${1};

    if [ "x" != "x${directoryPath}" ]
    then
        mkdir -p ${directoryPath};
    fi
}

function getGangliaClusterInfo()
{
    clusterName=${1};

    if [ "x" != "x${clusterName}" ]
    then
        # Fetch the particular entry for ${clusterName} from ${GANGLIA_CLUSTERS_CONF_FILE}.
        awk -v clusterName=${clusterName} '($1 !~ /^#/) && ($1 == clusterName)' ${GANGLIA_CLUSTERS_CONF_FILE};
    else
        # Spit out all the non-comment, non-empty lines from ${GANGLIA_CLUSTERS_CONF_FILE}.
        awk '($1 !~ /^#/) && (NF)' ${GANGLIA_CLUSTERS_CONF_FILE};
    fi
}

function getConfiguredGangliaClusterNames()
{
  # Find all the subdirectories in ${GANGLIA_CONF_DIR} and extract only 
  # the subdirectory name from each.
  if [ -e ${GANGLIA_CONF_DIR} ]
  then  
    find ${GANGLIA_CONF_DIR} -maxdepth 1 -mindepth 1 -type d | xargs -n1 basename;
  fi
}
