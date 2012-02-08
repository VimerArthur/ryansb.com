# break it down

	!python
	y = ['hello', 'my', 'name', 'STOP', 'is', 'ekans']
	while y:
		if y == 'STOP':
			print 'HALTING EVERYTHING'
			break
		print y.pop()

ekans

is

HALTING EVERYTHING

---

# next time around
	!python
	y = ['hello', 'my', 'name', 'SKIP', 'is', 'ekans']
	while y:
		if y == 'SKIP':
			continue
		print y.pop()

ekans

is

name

my

hello

---

# pass the buck

pass is great when you want to do nothing on a certain condition
