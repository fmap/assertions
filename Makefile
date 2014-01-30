default: build

setup: assert.cabal Test
	ghc Setup.hs

build: setup 
	./Setup --user configure
	./Setup build 

install: build
	./Setup install

tests: install
	ghc test/*.hs

test: tests
	./test/Assert

clean: 
	git clean -Xfd
