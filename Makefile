#----------------------------------------------------------
# makefile latex
# elaborado por ferney beltrán ferney.beltran@gmail.com
# septiembre 2013   
#----------------------------------------------------------

_LATEX_NAME   =   Tesis
_DIR_TMP      =   tmp
_DIR_BACKUP   =   backups
_DIR_IMAGES   =  images
_NAME_BIBLIO  =  biblio_tesis.bib  

# Generación del documento utilizando latex y dvipdf con mekeglossaries
latex: dtmp
	latex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	@cp $(_NAME_BIBLIO) $(_DIR_TMP)/$(_NAME_BIBLIO) 
	@cd $(_DIR_TMP); bibtex $(_LATEX_NAME)
	@cd $(_DIR_TMP); makeglossaries $(_LATEX_NAME)
	latex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	latex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	dvips  $(_DIR_TMP)/$(_LATEX_NAME).dvi
	ps2pdf $(_LATEX_NAME).ps
	
#	dvipdf  $(_DIR_TMP)/$(_LATEX_NAME).dvi

# Generación del documento utilizando pdflatex
pdflatex:dtmp
	pdflatex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	-@cd $(_DIR_TMP);-bibtex $(_LATEX_NAME)		# se coloca el - para saltar los fallos
	-@cd $(_DIR_TMP);makeglossaries -q $(_LATEX_NAME)
	pdflatex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	pdflatex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)

fastpdf:dtmp
	pdflatex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)

fastlatex:dtmp
	latex -output-directory=$(_DIR_TMP) $(_LATEX_NAME)
	dvips  $(_DIR_TMP)/$(_LATEX_NAME).dvi
	ps2pdf $(_LATEX_NAME).ps

clean:
	@echo Borrando los ficheros temporales...
	@rm -fR $(_DIR_TMP)
	@echo Borrando los ficheros de salida ps...
	@rm -f *.ps
	@echo Borrando los ficheros de salida...
	@rm -f *.pdf


zipBackup:latex dbackup
	mv $(_LATEX_NAME).pdf $(_LATEX_NAME).pdf_
	make clean
	mv $(_LATEX_NAME).pdf_ $(_LATEX_NAME).pdf
	zip -r $(_LATEX_NAME).zip . -x *.zip $(_DIR_BACKUP)/*.* 
	@mv $(_LATEX_NAME).zip $(_DIR_BACKUP)/$(_LATEX_NAME)`date --iso`.zip

# creación de la extructura de directorios temporal  
dtmp:
	@if [ ! -d $(_DIR_TMP) ]; then mkdir $(_DIR_TMP); fi
	@for dir in */; 	do \
		tmpdir=$(_DIR_TMP)/$$dir;\
		if [ ! -d $$tmpdir ] && \
			[ "$$dir" != "$(_DIR_TMP)/" ] && \
			[ "$$dir" != "$(_DIR_BACKUP)/" ] && \
			[ "$$dir" != "$(_DIR_IMAGES)/" ]; then \
			mkdir $$tmpdir; \
			echo creando $$tmpdir ...;\
		fi; \
	done

dbackup:
	@if [ ! -d $(_DIR_BACKUP) ]; then mkdir $(_DIR_BACKUP); fi
