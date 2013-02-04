# Makefile to translate m4 character sheets into ps, dvi or pdf
# You can put this into a "working" directory or directly into your 
# "characters" directory.

#.SILENT:

# specify the rules base directory
RULES_DIR = ../Rules
# specify the character sources directory
CHARACTERS_DIR = ../Characters

%.__m4: $(CHARACTERS_DIR)/%.m4
	if [ -L $(@) ]; then rm $(@); fi
	ln -s $(<) $(@)

%.__inc: $(CHARACTERS_DIR)/%.inc
	if [ -L $(@) ]; then rm $(@); fi
	ln -s $(<) $(@)
	if [ -L $(notdir $(<)) ]; then rm $(notdir $(<)); fi
	ln -s $(<) $(notdir $(<))

%.tex: %.__m4 %.__inc
	#echo filename = `echo $(<) | sed -e's/char_\([a-z]*\)\.m4/\1/'`
	m4 -I$(RULES_DIR) -Dchar_filename=`echo $(<) | sed -e's/char_\([a-z]*\)\.__m4/\1/'` < $(<) > $(@)
	if [ -L $(basename $(@)).inc ]; then rm $(basename $(@)).inc; fi


%.dvi: %.tex
	latex $(<)
	latex $(<)
	if [ -e $(basename $(@)).log ]; then rm $(basename $(@)).log; fi
	if [ -e $(basename $(@)).aux ]; then rm $(basename $(@)).aux; fi

%.ps: %.dvi
	dvips -t a4 -o $(@) $(<)

%.ps.gz: %.ps
	gzip --best -f $(<)

%.pdf: %.tex
	pdflatex $(<)
	pdflatex $(<)
	if [ -e $(basename $(@)).log ]; then rm $(basename $(@)).log; fi
	if [ -e $(basename $(@)).aux ]; then rm $(basename $(@)).aux; fi




# This creates phony targets in order to be able to request
#   make <name>   and get char_<name>.<DEFAULT_FORMAT>

#CHARACTER_FILES := $(CHARACTERS_DIR)/char_*.m4
#CHARACTER_NAMES = $(CHARACTER_FILES:$(CHARACTERS_DIR)/char_%.m4=%)
#CHARACTER_NAMES = tjaldik william urivol urik hannah helen liro gigglenot hazela arianna
CHARACTER_NAMES = liro gigglenot
DEFAULT_FORMAT = pdf

.PHONY : $(CHARACTER_NAMES)
$(CHARACTER_NAMES):
	#echo CHARACTER_FILES = $(CHARACTER_FILES)
	#echo CHARACTER_NAMES = $(CHARACTER_NAMES)
	make char_$(@).$(DEFAULT_FORMAT)

# Default:

.PHONY : all
all: $(CHARACTER_NAMES)

# clean tex temporary files

.PHONY : clean

clean:
	-rm *.aux
	-rm *.dvi
	-rm *.log
	-rm *.pdf
	-rm *.ps
	-rm *.ps.gz
	-rm *.tex

	
	

