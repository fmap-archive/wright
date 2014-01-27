default: build

setup: colour.cabal Data Control
	ghc Setup.hs

build: setup 
	./Setup --user configure
	./Setup build 

install: build
	./Setup install

clean: setup
	git clean -Xfd
