# This makefile is downloading an archive found in 
# the 'archive' file already existing in this directory
# and validating the md5sum of the archive against it.
NAME := bzip2

define find-common-dir
for d in common ../common ../../common ; do if [ -f $$d/Makefile.common ] ; then echo "$$d"; break ; fi ; done
endef
COMMON_DIR := $(shell $(find-common-dir))

include $(COMMON_DIR)/Makefile.common

SOURCEFILES := $(shell cat sources 2>/dev/null | awk '{ print $$2 }')

sources: $(SOURCEFILES)

$(SOURCEFILES):
	$(CLIENT) $(LOOKASIDE_URI)/$(NAME)/$(SOURCEFILES)
	md5sum -c sources || ( echo 'MD5 check failed' && rm $(SOURCEFILES); exit 1 )

clean:
	rm $(SOURCEFILES)
