# indexer - for performing many calculations in very large logfiles 

In this case I want to performn a few hundred calculation per domain on a file that is 2,3 rows long. It does not make much difference what kind of computations you want to make, if you want to avoid putting your data in to a database, this indexer is for you. 

Using a 8gb 4 core Linux box, the indexing time is roughly 1 day per 1,5 bn rows of logfile with 4 columns (IP, two different referrer fields and a timestamp). This is the price we pay for very fast computations later. 

