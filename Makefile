#----------------------------------------------------------
# makefile latex
#----------------------------------------------------------

_LATEX_NAME = Tesis
_GLOSSARY_FILE = acronimos.gdf

_DIR_CONFIG =00_config
_DIR_VARIOS =00_varios
_DIR_INTRO = 01_introduction
_DIR_CHAPTERS =02_Chapters
_DIR_APPENDIX =03_Appendix


# Generación del documento utilizando pdflatex
pdflatex:
	 pdflatex $(_LATEX_NAME)
	-bibtex $(_LATEX_NAME)		# se coloca el - para saltar los fallos
	-glosstex $(_LATEX_NAME) $(_GLOSSARY_FILE)
	-makeindex $(_LATEX_NAME).gxs -o $(_LATEX_NAME).glx -s glosstex.ist
	 pdflatex $(_LATEX_NAME)
	 pdflatex $(_LATEX_NAME)	

# Generacón del documento utilizando latex
latex: 
	 latex $(_LATEX_NAME)
	-bibtex $(_LATEX_NAME)
	-glosstex $(_LATEX_NAME) $(_GLOSSARY_FILE)
	-makeindex $(_LATEX_NAME).gxs -o $(_LATEX_NAME).glx -s glosstex.ist
	latex $(_LATEX_NAME)
	latex $(_LATEX_NAME)
	dvips $(_LATEX_NAME).dvi
	ps2pdf $(_LATEX_NAME).ps


fast:
	pdflatex $(_LATEX_NAME)

fastlatex:
	latex $(_LATEX_NAME)
	dvips $(_LATEX_NAME).dvi
	ps2pdf $(_LATEX_NAME).ps


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
	@echo Borrando ficheros aux. de configuración ...
	@if [ -d $(_DIR_CONFIG) ]; then cd $(_DIR_CONFIG); make clean; fi
	@cd $(_DIR_VARIOS); make clean
	@echo Borrando ficheros aux. de introducción...
	@if [ -d $(_DIR_INTRO) ]; then cd $(_DIR_INTRO); make clean; fi
	@echo Borrando ficheros aux.de los capítulos...
	@if [ -d $(_DIR_CHAPTERS)]; then cd $(_DIR_CHAPTERS); make clean; fi
	@echo Borrando ficheros aux. de los apéndices...
	@if [ -d $(_DIR_APPENDIX) ]; then cd $(_DIR_APPENDIX); make clean; fi


distclean: clean
	@echo Borrando los ficheros de salida...
	@rm -f *.pdf
	@echo Borrando las copias de seguridad de los editores...
	@rm -f *~
	@rm -f *.backup
	@echo Borrando los ficheros de distribución...
	@rm -f *.tar.gz
	@echo Borrado recursivo de los ficheros de configuración...
	@echo Borrando ficheros aux. de configuración ...
	@if [ -d $(_DIR_CONFIG) ]; then cd $(_DIR_CONFIG); make distclean; fi
	@cd $(_DIR_VARIOS); make distclean
	@echo Borrando ficheros aux. de introducción...
	@if [ -d $(_DIR_INTRO) ]; then cd $(_DIR_INTRO); make distclean; fi
	@echo Borrando ficheros aux.de los capítulos...
	@if [ -d $(_DIR_CHAPTERS)]; then cd $(_DIR_CHAPTERS); make distclean; fi
	@echo Borrando ficheros aux. de los apéndices...
	@if [ -d $(_DIR_APPENDIX) ]; then cd $(_DIR_APPENDIX); make distclean; fi

crearBackup: 
	make clean
	make pdflatex
	mv $(_LATEX_NAME).pdf $(_LATEX_NAME).pdf_
	make distclean
	mv $(_LATEX_NAME).pdf_ $(_LATEX_NAME).pdf
	zip -r ../$(_LATEX_NAME).zip .


