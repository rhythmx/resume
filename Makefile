all: out

CoverLetterExample.pdf: CoverLetterExample.tex
	xelatex CoverLetterExample.tex

PublicResume.pdf: PublicResume.tex
	xelatex PublicResume.tex

out: PublicResume.pdf CoverLetterExample.pdf
	cp CoverLetterExample.pdf out/
	cp PublicResume.pdf out/Sean\ Bradly\ -\ Resume\ 2021.pdf

clean:
	rm -f *.aux *.log *.pdf *.out

