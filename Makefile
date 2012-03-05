update:
	jekyll --pygments
	sudo cp -r _site/* /var/www/html
compile:
	jekyll --pygments
