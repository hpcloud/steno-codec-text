#
# Makefile for steno-codec-text
#
# Used solely by packaging systems.
# Must support targets "all", "install", "uninstall".
#
# During the packaging install phase, the native packager will
# set either DESTDIR or prefix to the directory which serves as
# a root for collecting the package files.
#
# The resulting package installs in /home/stackato/stackato/code,
# is not intended to be relocatable.
#

NAME=steno-codec-text

INSTALLHOME=/home/stackato
INSTALLBASE=$(INSTALLHOME)/stackato
INSTALLROOT=$(INSTALLBASE)/code
DIRNAME=$(INSTALLROOT)/steno-codec-text

HOMEDIR=$(DESTDIR)$(prefix)$(INSTALLHOME)
BASEDIR=$(DESTDIR)$(prefix)$(INSTALLBASE)
INSTDIR=$(DESTDIR)$(prefix)$(DIRNAME)

RSYNC_EXCLUDE=--exclude=/.git* --exclude=/Makefile --exclude=/.stackato-pkg --exclude=/debian --exclude=/etc

all:
	@ true

install:
	mkdir -p $(INSTDIR)
	rsync -ap . $(INSTDIR) $(RSYNC_EXCLUDE)
	if [ -d etc ] ; then rsync -ap etc $(BASEDIR) ; fi
	chown -R stackato.stackato $(HOMEDIR)

uninstall:
	rm -rf $(INSTDIR)

clean:
	@ true

# eg: make dev-push VM=y9ba
dev-push:
	rsync -rtv --exclude .stackato-pkg --exclude .git \
         . stackato@${TARGET}:/s/code/steno-codec-text

