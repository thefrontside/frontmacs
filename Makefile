build:
	mkdir -p build/home
	mkdir -p build/lib
	cp -r .emacs.d build/home
	cp *.el build/lib

build/packages/archive-contents:
	cask package
	mkdir -p dist/packages
	emacs -Q --batch --no-init-file --script scripts/build-archive.el
	cp dist/*.txt dist/packages
clean:
	rm -rf build
	rm -rf dist

runlocal: build
	FRONTMACS_RUNLOCAL=true HOME=`pwd`/build/home cask emacs

archive: build/packages/archive-contents
