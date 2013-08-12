# Type "make help" for information about targets.

MAKE_SCRIPTS := scripts/makefile

export PYTHONPATH := projects/haplorec/src/python:$(PYTHONPATH)

all: doc

help:
	@$(MAKE_SCRIPTS)/usage.py

doc:
	sphinx-apidoc --force projects/haplorec/src/python/pharmgkb -o source/apidoc 
	sphinx-build -b html source documentation

