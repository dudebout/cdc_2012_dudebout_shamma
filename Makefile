paper_dir = ./paper/
simulations_dir = ./simulations/
readme = README.md
abstract = $(addprefix $(paper_dir), abstract.tex)
bibtex = entry.bib
copyright = COPYRIGHT

all: paper readme

readme: $(readme)

$(readme): $(abstract) $(bibtex) $(copyright)
	echo "#Empirical Evidence Equilibria in Stochastic Games" > $@
	echo "**Nicolas Dudebout and Jeff S. Shamma**\n" >> $@

	echo "" >> $@

	echo "##Abstract" >> $@
	cat $(abstract) >> $@

	echo "" >> $@

	echo "##BibTeX" >> $@
	cat $(bibtex) | sed 's/^/    /' >> $@

	echo "" >> $@

	echo "##Copyright" >> $@
	cat $(copyright) >> $@

.PHONY: paper
paper: simulations
	$(MAKE) -C $(paper_dir)

.PHONY: simulations
simulations:
	$(MAKE) -C $(simulations_dir)

.PHONY: clean
clean:
	$(MAKE) -C $(paper_dir) clean
	$(MAKE) -C $(simulations_dir) clean
	rm -f $(readme)
