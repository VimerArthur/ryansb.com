!SLIDE center
![](img/octocat.png)
## github.com ##

!SLIDE center
![](img/search.png)

!SLIDE

# 800,000 original projects #

	>> Repository.count(:conditions => 
		{ :parent_id => nil, :public => 1 })
	=> 805411

!SLIDE
# be part of a community #

!SLIDE bullets incremental

# contribute back #

* fork
* commit
* push 
* (pull request)

!SLIDE commandline incremental
	$ git clone git://github.com/some1/project
	Cloning into project...
	$ cd project/
	$ vim README
	$ git commit -am 'made it better'
	[master dbeb245] made it better
	 1 files changed, 2 insertions(+), 0 deletions(-)
	$ (fork it on github)
	$ git remote add myfork git@github.com:you/project.git
	$ git push myfork master:feature_name
	...
	To git@github.com:you/project.git
	   9457e38..dbeb245  master -> feature_name

!SLIDE

# one minute #

!SLIDE commandline
<pre>
$ git clone git://github.com/some1/project
Cloning into project...
$ cd project/
$ vim README
$ git commit -am 'made it better'
[master dbeb245] made it better
 1 files changed, 2 insertions(+), 0 deletions(-)
$ (fork it on github)
$ git remote add myfork git@github.com:you/project.git
$ <span class="red">git push myfork master:feature_name</span>
...
To git@github.com:you/project.git
	9457e38..dbeb245  master -> feature_name
</pre>

!SLIDE
# cheap branching #

!SLIDE
# TODO:Pull request screenshot #

!SLIDE
# cheap contributions #
