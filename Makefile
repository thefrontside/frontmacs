build:
	mkdir -p build/home
	mkdir -p build/lib
	cp -r .emacs.d build/home
	cp *.el build/lib
clean:
	rm -rf build

runlocal: build
	FRONTMACS_RUNLOCAL=true HOME=`pwd`/build/home emacs -nw
