clean:
	rm -rf .emacs.d/elpa
	rm -rf .emacs.d/smex-items
	rm -rf .emacs.d/quelpa

runlocal: clean
	HOME=`pwd` emacs
