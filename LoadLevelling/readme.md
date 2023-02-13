Solution 1: 
Model the cache as a Dictionary<DateTime, int>
Go to the cache and lookup the key, as DateTime.Now rounded down to the nearest minute
If it's not there, insert 1 into the Dictionary
If it is there and less than 250, add one to the current value of the Dictionary

Solution 2: Add locks