# The lmfdb servers and code

There are two web servers each running a different brnach of the lmfdb code:

1. www.lmfdb.org points to lmfd.warwick.ac.uk:37001 and runs prod.
2. beta.lmfdb.org points to lmfd.warwick.ac.uk:37002 and runs beta.

The configuration files for these are in ~/lmfdb-git-prod/gunicorn-config and ~/
lmfdb-git-beta/gunicorn-config-beta.  The main difference, apart from the port number and the number of threads (more for prod) is that beta runs with the environment variable BETA set to 1, while on prod it is unset.  The PIDs of the associated python processes are stored in ~/gunicorn.pid and ~/gunicorn-beta.pid .

There is a bare git repository in ~/lmfdb.git to which updated version of the branches prod and beta are pushed when it is decided that the server's code needs updating.  This happens rarely for prod but much more often for beta (essentially every time any new code is merged after review).  Directories lmfdb-git-prod and lmfdb-git-beta have the current prod and beta branches checked out, and when new commits to either of these are pushed to lmfdb.git, the script ~/lmfdb.git/hooks/post-receive updates those and restarts the relevant server.

The directories lmfdb-git-{prod, beta} contain these checked out branches but are not themselves git repositories (they have no .git subdirectory).  Each has an additional gunicorn config file (see previous paragraph) and a file flasklog which logs server requests and error messages.  I do not know when the flasklog files are deleted and new ones started, but no backups of these logs appear to be created automatically.
 
For testing, there is also a normal lmfdb directory in ~/lmfdb, whose only remote is origin = git@github.com:LMFDB/lmfdb.git  Using this it is possible to test changes before they are pushed to the live servers (by pushing into ~/lmfdb.git) on the same Sage versions as the servers are running.  For example, to test a proposed new push to beta, first run the unit tests:

```
cd ~/lmfdb
git pull origin beta
SAGE=~/sage-beta/sage ./test.sh
```
and also run the server (as one would for local development), making sure to use a port other than 37001, 37002, for example
```
cd ~/lmfdb
git pull origin beta
export BETA=1
~/sage-beta/sage -python ./start-lmfdb -p 37777
```
and then open your browser to lmfdb.warwick.ac.uk:37777 (or use ssh tunelling to a local port).

It is not normally necessary to manually start or restart either server.  One situation is to change the Sage version running (see readme-sage for that).  Another is if either server stops running for an unknown reason (which does happen, if rarely), then use the start script (but make sure that the mongod process is running first).
