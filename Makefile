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

tests: install
	find tests -name '*hs' | xargs -I+ ghc -itests +

test: tests
	./tests/Convert
	./tests/Diff
