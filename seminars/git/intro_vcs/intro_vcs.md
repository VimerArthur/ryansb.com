!SLIDE bullets incremental
# what is VCS? #

* version control system
* control changes
* know what changed, when, and who did it
* share it

!SLIDE bullets incremental
* ## centralized ##
* ## distributed ##

!SLIDE bullets incremental
# centralized #
* SVN, RCS, Clearcase
* store diffs
* central database

!SLIDE bullets incremental
# distributed #
* Git, Mercurial
* store blobs
* everyone has a copy of the database
* ## locally ##

!SLIDE bullets incremental
# why care? #
* concurrency, simply
* easy merges
* fast collaboration

!SLIDE bullets incremental
# why Git? #
* simple design
* fully distributed
* easily handle massive projects (linux)
* cheap branching
* flexibility

!SLIDE subsection
# first, clear your mind #

!SLIDE bullets incremental
# why Git is fast #
* almost everything is local
* work on planes, trains, and automobiles
* upload when you can

!SLIDE bullets incremental
# a commit is... #
* snapshot, not a diff
* takes up more space, but bits are cheap
* acts almost like a mini filesystem
* store links to files that haven't changed
* refer to commits by checksums (not names)

!SLIDE bullets incremental
# how to stop worrying #
* Git generally only adds data
* it's hard to lose things once committed
* almost always possible to roll back changes

!SLIDE bullets incremental
# a commit has... #
* a checksum
* a list of all blobs contained in the commit
* a comment (please use these)

!SLIDE
# three stages of Git #
<center>
  <table>
    <tr>
      <th>working</th>
      <th>staging</th>
      <th>repo</th>
    </tr>
    <tr>
      <td>uncommitted</td>
      <td>preparing to commit</td>
      <td>committed</td>
    </tr>
  </table>
</center>

!SLIDE bullets
# basic workflow #
* one: make some changes
* two: stage snapshots of files
* three: commit
* four: (eventually) push