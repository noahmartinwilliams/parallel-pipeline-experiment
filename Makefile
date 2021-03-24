GHC=ghc -dynamic -rtsopts -threaded
GHCD=$(GHC) -eventlog

.PHONY:
test: Main.hs
	$(GHCD) --make Main
	seq 0 100000 | ./Main +RTS -N -l -RTS
	threadscope Main.eventlog

Main: Main.hs
	$(GHC) --make Main

.PHONY:
clean:
	rm *.o || true
	rm *.hi || true
	rm Main || true
	rm Main.eventlog || true
