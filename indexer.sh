
        # goes once in to the main file and creates temp file based on key1
        # number of keys at this stage reduce time taken for calculations 
        # but increase the time to build the index.

#	SOURCEFILE=(indexer.input)
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
