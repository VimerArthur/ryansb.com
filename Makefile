update:
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments
	sudo rm -rf /var/www/html/*
	sudo cp -r _site/* /var/www/html

compile:
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments

devel:
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments --auto --server

less:
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
