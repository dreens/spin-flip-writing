filename=MolecularSpinFlipLoss
sname=Supplement

pdf:
	pdflatex ${filename}
	bibtex ${filename}||true
	pdflatex ${filename}
	pdflatex ${filename}
	open -a Preview ${filename}.pdf

supp:
	pdflatex ${sname}
	bibtex ${sname}||true
	pdflatex ${sname}
	pdflatex ${sname}
	open -a Preview ${sname}.pdf
	
figs:
	bash compile_figures

diff:
	bash dodiff

clean:
	rm -f ${filename}.{ps,pdf,log,aux,out,dvi,bbl,blg}
	rm -f ${sname}.{ps,pdf,log,aux,out,dvi,bbl,blg}
