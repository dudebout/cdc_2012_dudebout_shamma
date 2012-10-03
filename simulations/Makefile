types = theoretical empirical
full_names = $(addprefix simulation_, $(types))
executable_files = $(full_names)
haskell_files = $(addsuffix .hs, $(full_names))
data_files = $(addsuffix .dat, $(full_names))

all: $(data_files)

%.dat: %
	./$< > $@

$(executable_files): %: %.hs
	ghc --make -O2 -i./game-theoretic-learning/ $< -o $@

.PHONY: clean
clean:
	rm -f *.hi *.o $(data_files) $(executable_files)
