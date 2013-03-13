# Borra todos los ficheros intermedios 
clean:
	@echo Borrando los ficheros log...
	@rm -fR *.log
	@echo Borrando los ficheros aux out exa...
	@rm -fR *.aux
	@rm -fR *.out
	@rm -fR *.exa
	@echo Borrando ficheros de generación de índices de palabras...
	@rm -f *.idx
	@rm -f *.ilg
	@rm -f *.ind
	@echo Borrando ficheros de generación de tablas de contenidos...
	@rm -f *.toc
	@rm -f *.lof
	@rm -f *.lot
	@echo Borrando los ficheros de generación de acrónimos...
	@rm -f $(_LATEX_NAME).g*
	@echo Borrando los ficheros de salida dvi ps...
	@rm -f *.dvi
	@rm -f *.ps
	@echo Borrando los ficheros bbl blg de BibTeX...
	@rm -f *.bbl
	@rm -f *.blg


distclean: clean
	@echo Borrando los ficheros de salida...
	@rm -f *.pdf
	@echo Borrando las copias de seguridad de los editores...
	@rm -f *~
	@rm -f *.backup
	@echo Borrando los ficheros de distribución...
	@rm -f *.tar.gz

