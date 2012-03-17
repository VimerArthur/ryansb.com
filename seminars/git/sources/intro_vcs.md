# what is VCS?

* version control system
* control changes
* know what changed, when, and who did it
* share it

---

centralized
===========

---

distributed
===========

---

# centralized
* SVN, RCS, Clearcase
* store diffs
* central database

---

# distributed
* Git, Mercurial
* store blobs
* everyone has a copy of the database
* can have many remotes
* no final authority
* locally

---

# why care?
* concurrency, simply
* easy merges
* fast collaboration

---

# why Git?
* simple design
* fully distributed
* easily handle massive projects (linux)
* cheap branching
* flexibility

---

first, clear your mind
======================

---

# Git is fast
* almost everything is local
* work on planes, trains, and automobiles
* upload when you can

---

# a commit is...
* snapshot, not a diff
* takes up more space, but bits are cheap
* acts almost like a mini filesystem
* store links to files that haven't changed
* refer to commits by checksums (not names)

---

# how to stop worrying #
* Git generally only adds data
* it's hard to lose things once committed
* almost always possible to roll back changes
* other than 'fetch', 'push', and 'pull', nearly everything is local

---

# a commit has...
* a checksum
* a list of all blobs contained in the commit
* a comment (please use these)

---

# three (or four) stages of Git #
![](img/three_stages.png)

Protips:

	!bash
	# set commit message without opening an editor
	git commit -m 'commit message'
	# add only parts of what was changed
	git add -p

---

# basic workflow #
1. ### make some changes
1. ### stage snapshots of files
1. ### commit
1. ### (eventually) push

