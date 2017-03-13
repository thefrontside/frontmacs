# Set up the home directory to run the simulated emacs. This just uses
# `scripts/init-frontmacs.el` as the initialization script
build:
	mkdir -p build/home/.emacs.d
	echo "(load (expand-file-name \"../../../scripts/init-frontmacs.el\" user-emacs-directory))" > `pwd`/build/home/.emacs.d/init.el

build/packages/archive-contents:
	cask package
	rm -rf dist/packages
	mkdir -p dist/packages
	emacs -Q --batch --no-init-file --script scripts/build-archive.el
	cp dist/*.txt dist/packages
clean:
	rm -rf build
	rm -rf dist

# Run Emacs locally with a sandboxed home directory, using the
# frontmacs config. We point Emacs to the local archive that we built
# on the system, and also erase it if it was there befor.
runlocal: build archive
	rm -rf build/home/.emacs.d/elpa/archives/frontside
	rm -rf build/home/.emacs.d/elpa/archives/frontmacs-*
	FRONTMACS_ARCHIVE=`pwd`/dist/packages/ HOME=`pwd`/build/home cask emacs -nw

archive: build/packages/archive-contents

# Make sure that running the init-frontmacs.el script actually
# downloads everything off of the internet
init-test: build archive
	FRONTMACS_ARCHIVE=`pwd`/dist/packages/ HOME=`pwd`/build/home emacs -Q --batch --no-init-file --script scripts/init-frontmacs.el
