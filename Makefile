compressupdate:
	git pull
	ppmtowinicon -output favicon.ico favicon.pnm
	lessc bootstrap/less/bootstrap.less > _includes/bootstrap.css
	lessc _includes/screen.less > _includes/screen.css
	jekyll --pygments
	python -c "from slimmer import css_slimmer; import sys; print css_slimmer(open('_site/css/main.css').read())" > _site/css/compressed_main.css
	mv _site/css/compressed_main.css _site/css/main.css
	sudo rm -rf /var/www/html/*
	sudo cp -r _site/* /var/www/html

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
