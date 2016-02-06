#!/bin/bash

# to start you need a large dataset where the first column data can
# be used as a key for the index. 

# there are two ways to control the compute time, one is the key1 and 
# the other is key2. Roughly speaking: 
#						key1	key2	
# very big file with many things to do		>50	>1500
# very big file but not so many things to do	>50	>500
# smaller file with many things to do		>20	>500

# KEY1SIZE=()
# KEY2SIZE=()
# SOURCEFILE=()

	cat indexer.input | colrm 3 | grep -e ^"[a-zA-Z0-9]" | sort -u > indexer.keyspace
	cat indexer.keyspace | colrm 3 > indexer.key1

        while read KEY1
                do
                LC_ALL=C grep ^"$KEY1" indexer.input > "$KEY1".temp
                LC_ALL=C grep ^"$KEY1" indexer.keyspace > indexer.key2

                # now based on that goes on to create the index files based
                # on the seleted subset of the keyspace 

                while read KEY2
                        do
                LC_ALL=C grep -e ^"$KEY2" "$KEY1".temp > "$KEY2"
                done <indexer.key2

                # removes the temp file for the key2 set and moves to the next key 

                rm "$KEY1".temp
        done <indexer.key1
