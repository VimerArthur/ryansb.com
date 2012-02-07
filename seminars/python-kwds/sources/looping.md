# while you can
	!python
	>>> y = ['hello', 'my', 'name', 'is', 'ekans']
	>>> while y:
	>>>	print y.pop()
	'ekans'
	'is'
	'name'
	'my'
	'hello'

---

# give them what for
	!python
	>>> y = ['hello', 'my', 'name', 'is', 'ekans']
	>>> for x in y:
	>>>	print x
	>>> else:
	>>>	print x + ' goodbye' # retains variables and scope of for loop
	'hello'
	'my'
	'name'
	'is'
	'ekans'
	'exans goodbye'
