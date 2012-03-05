update:
	jekyll --pygments
	sudo cp -r _site/* /var/www/html

compile:
	jekyll --pygments

devel:
	jekyll --pygments --auto --server
