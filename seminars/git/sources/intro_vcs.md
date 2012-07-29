# what is VCS?

* version control system
* what changed
* when
* who did it

---

# centralized
* SVN, RCS, Clearcase
* central database

---

# distributed
* Git, Mercurial
* everyone has a copy of the database
* can have many remotes
* no final authority
* locally

---

# why care?
* concurrent collaboration
* easy merges
* network independent
* redundancy

---

# why Git?
* handle massive projects (linux)
* branching
* flexibility
* speed
* almost everything is local
* work on planes, trains, and automobiles

---

# a commit is...
* snapshot, not a diff
* takes up more space, but bits are cheap
* acts almost like a mini filesystem
* store links to files that haven't changed
* refer to commits by checksums (not names)

---

# stop worrying
* Git (generally) only adds data
* it's hard to lose things once committed
* almost always possible to roll back changes
* other than 'fetch', 'push', and 'pull', nearly everything is local

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

# a commit has...
* a checksum
* a list of all blobs contained in the commit
* a comment (please use these)

Format your commit like:

	80 character summary
	
	longer description of
	changes, maybe include a bulleted
	list of changes you made

---

# basic workflow #
1. ### make some changes
1. ### stage snapshots of files
1. ### commit
1. ### (eventually) push

