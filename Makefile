# Type "make help" for information about targets.

MAKE_SCRIPTS := scripts/makefile

all: doc

help:
	@$(MAKE_SCRIPTS)/usage.py

doc:
	sphinx-build -b html source documentation

