# Sage builds for lmfdb

There are three entirely independent Sage build directories: sage1, sage2 and sage3.  These may hold up to three different versions of Sage; see the file VERSION.txt in each for which is there.

There are two symbolic links, sage-prod and sage-beta, each pointing to one of the above directories, determining which version of Sage is running on prod (www.lmfdb.org) and beta (beta.lmfdb.org).  Thus at least one of the sage{1,2,3} directories is currently unused at any given time, and is used for upgrading to new Sage versions and testing.  Do **not** do any upgrading or building of Sage versions currently pointed to by sage-prod or sage-beta.

Each Sage build is normally a full Sage release (not a beta or rc pre-release).  In rare circumstances additional patches might be applied (for example if a bug which affects lmfdb running is fixed long before a new release is due out), and this should be documented here.  Each new Sage build *must* also have (1) the latest version of the conrey-dirichlet-characters module; (2) the optional Sage packages database_gap and gap_packages; (3) all the additional python modules list in the GettingStarted guide, as well as gunicorn.

After making a new Sage build, test that it works on the beta server see readme-lmfdb (replacing sage-beta with sage1/sage2/sage3 as appropriate).

To make the beta server start to use the new Sage version it seems to be necessary to actually stop the server and then start it rather than using its restart script.   For beta:

1. obtain the PID from `cat ~/gunicorn-beta.pid`
2. use `kill` to kill that process
3. delete the link sage-beta and make a new one to whichever of sage[123] is the new version
4. run ~/start-beta.

Now go to beta.lmfdb.org and see if it is up.   As a matter of courtesy to other developers, before doing the above steps email lmdb@googlegroups.com once well in advance with an estimate of when it will happen, again immedediately before killing the old process, and again when it is back up.
