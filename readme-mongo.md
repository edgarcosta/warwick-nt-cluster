# Mongo for lmfdb

We do not use the system-wide mongo on lmfdb.warwick.ac.uk (though no-one is sure why; perhaps when the system was set up the standard ubuntu package was not recent enough).  Instead we use a version built from source in directory  mongodb-linux-x86_64-2.4.9 (symlinked to ~/mongodb).  The current (2015-09-14) version of mongodb for ubuntu 14.04 is 2.4.9 and at some point it might be good to test if that works ok.

The mongo server is started and stopped using scripts/start-mongodb and scripts/stop-mongodb.  After starting it takes a minute or two for the servers to be able to connect to the database.  The database is not served on the default port for mongo but on port 37010, and the path for the database files is /home/lmfdb/db (set in the start script) which is also where the log file is.  When mongod (re)starts the old log is saved in a file in that directory.  Currently these log files total 8.7M lines, and one day it might be interesting to trawl them for information.

It has occasionally happened that the daemon stops for an unknown reason, in which case neither www.lmfdb.org nor beta.lmfdb.org home pages will load.  Restarting using the start-mongodb script can then be used.
