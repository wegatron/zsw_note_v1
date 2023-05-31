min:
	xelatex -shell-escape graphics_rendering.tex
	evince graphics_rendering.pdf

all: clean
	xelatex -shell-escape deep_into_graphics_rendering.tex
	bibtex deep_into_graphics_rendering.aux
	xelatex -shell-escape deep_into_graphics_rendering.tex
	xelatex -shell-escape deep_into_graphics_rendering.tex
	evince graphics_rendering.pdf

clean:
	rm -rf *.log *.out *.pdf *.blg *.bbl *.aux
