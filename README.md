# Dynamic IP Change Checker

ISPs like to assign dynamic IP addresses to their users. This can sometimes cause issues for automated scripts running against highly secured systems. 

You can pay extra for a static IP, but who wants to do that?

Instead, just tell me when my IP changes and I can adjust things as needed.

`build.sh` builds the docker image using secrets stored in a .env file.

The Dockerfile sets up a cron job to run every night at 12:05am Central Time. This job kicks off `check.sh` and records the output in "log.txt". If there's a mismatch between the recorded IP address and what it currently is then I get emailed.
