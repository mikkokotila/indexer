# indexer - for performing many calculations in very large logfiles 

In this case I want to performn a few hundred calculation per domain on a file that is 2,3 rows long. It does not make much difference what kind of computations you want to make, if you want to avoid putting your data in to a database, this indexer is for you. 

Using a 8gb 4 core Linux box, the indexing time is roughly 1 day per 1,5 bn rows of logfile with 4 columns (IP, two different referrer fields and a timestamp). This is the price we pay for very fast computations later. 

#### Let's look at the code and how to configure it to your need. 

    LC_ALL=C cat sample | colrm 3 | grep -e ^"[a-zA-Z0-9]" | sort -u > indexer.keyspace
    cat indexer.keyspace | colrm 2 > indexer.key1

        while read KEY1
                do
                LC_ALL=C grep -e ^"$KEY1" sample > "$KEY1".temp
                LC_ALL=C grep -e ^"$KEY1" indexer.keyspace > indexer.key2

                while read KEY2
                        do
                LC_ALL=C grep -e ^"$KEY2" "$KEY1".temp > "$KEY2"
                done <indexer.key2

                rm "$KEY1".temp
        done <indexer.key1
