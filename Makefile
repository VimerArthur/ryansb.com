update:
	lessc --compress bootstrap/less/bootstrap.less > css/bootstrap.css
	lessc --compress css/screen.less > css/screen.css
	jekyll --pygments
	sudo cp -r _site/* /var/www/html

compile:
	lessc --compress bootstrap/less/bootstrap.less > css/bootstrap.css
	lessc --compress css/screen.less > css/screen.css
	jekyll --pygments

devel:
	lessc --compress bootstrap/less/bootstrap.less > css/bootstrap.css
	lessc --compress css/screen.less > css/screen.css
	jekyll --pygments --auto --server

less:
	lessc --compress bootstrap/less/bootstrap.less > css/bootstrap.css
	lessc --compress css/screen.less > css/screen.css
