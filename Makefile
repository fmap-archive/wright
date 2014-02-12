default: 

build: src/ wright.cabal
	cabal configure 
	cabal build

install: build
	cabal install

clean: 
	git clean -Xfd

tests: 
	cabal configure --enable-tests
	cabal build

test: tests
	cabal test
