update:
	git pull
	ppmtowinicon -output favicon.ico favicon.pnm
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments
	sudo rm -rf /var/www/html/*
	sudo cp -r _site/* /var/www/html

compile:
	ppmtowinicon -output favicon.ico favicon.pnm
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments

devel:
	ppmtowinicon -output favicon.ico favicon.pnm
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments --auto --server

less:
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
