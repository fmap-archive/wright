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
	cp -r test/fixtures dist/build/wright-tests # hack

test: tests
	cabal test
