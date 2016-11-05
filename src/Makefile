SUBDIRS=dmabuf-sharing

recursive=all clean

all:

$(recursive):
	@target=$@ ; \
	for subdir in $(SUBDIRS); do \
		echo "Making $$target in $$subdir" ; \
		$(MAKE) -C $$subdir $$target; \
	done
