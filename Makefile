# This makefile is downloading an archive found in 
# the 'archive' file already existing in this directory
# and validating the md5sum of the archive against it.

define find-common-dir
for d in common ../common ../../common ; do if [ -f $$d/Makefile.common ] ; then echo "$$d"; break ; fi ; done
endef
COMMON_DIR := $(shell $(find-common-dir))

include $(COMMON_DIR)/Makefile.common

SOURCEFILES := $(shell cat archive 2>/dev/null | awk '{ print $$2 }')

sources: $(SOURCEFILES)

$(SOURCEFILES):
	$(CLIENT) $(LOOKASIDE_URI)/$(NAME)/$(SOURCEFILES)
	md5sum -c archive || ( echo 'MD5 check failed' && rm $(SOURCEFILES); exit 1 )

clean:
	rm goose-release-6.tar.gz
