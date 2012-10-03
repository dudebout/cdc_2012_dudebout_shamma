pdfs = paper.pdf
latex-makefile = ./latex-makefile
dependencies = symb.sty abstract.tex nomenclature.tex content.tex simulation.tikz ../simulations/simulation_theoretical.dat ../simulations/simulation_empirical.dat

all: $(pdfs)

$(pdfs): %.pdf: %.tex $(dependencies)
	$(MAKE) -f $(latex-makefile) $@

clean:
	$(MAKE) -f $(latex-makefile) clean
