
# imported from anywhere

	!python
	>>> import os
	>>> from os import getcwd
	>>> getcwd()
		'/home/user'
	>>> from os import getcwd as pwd
	>>> pwd()
		'/home/user'

---

# scoping and destroying

# global
	!python
	def fu():
		print y

	def func():
		global y
		print y

	fu() # raises a NameError
	y = "hello"
	func() # works, because global

# del
	!python
	>>> y = "Hello"
	>>> z = object()
	>>> print y, 'and', z
	hello and <object object at 0xb76e4740>
	>>> del y, z
	>>> print y, 'and', z
	NameError: name 'y' is not defined
