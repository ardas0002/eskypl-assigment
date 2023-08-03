# Assigment One
## Description
In this directory you can find a compressed tar archive (`logs.tar.bz2`), that contains directory with logs from web server.

Task is to create a script called `script.sh`, that will extract content of this archive and parse those log, so a number of request per IP can be shown.
Example of format:
```
ADDRESS              REQUESTS
10.0.0.1             10
10.0.0.2             20
```

### Bonus points
* Script should remove extracted files after successful parsing.
* Add to script option called "--user-agent", that allows restricting parsing of logs only to providded user agent.
* Add to script option called "--method", that prints in output number of request per method/address instead of just per address.
* Script should remove extracted files even in case of error.

### Instruction
To run script with two options you need to provide --method first then --user-agent.
Example:
./script.sh --method --user-agent="Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36"

To run script with one option the order doesn't matter.

!!Logs archive was deleted from repository because of large files limit in repository!!
