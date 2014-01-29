default: build

setup: wright.cabal Data Control
	ghc Setup.hs

build: setup 
	./Setup --user configure
	./Setup build 

install: build
	./Setup install

clean: 
	git clean -Xfd
