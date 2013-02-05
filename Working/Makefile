# Makefile to translate m4 character sheets into ps, dvi or pdf
# You can put this into a "working" directory or directly into your 
# "characters" directory.

.SILENT:


# specify the rules base directory
RULES_DIR = ../Rules
# specify the character sources directory
CHARACTERS_DIR = ../Characters

# specify LaTeX options
LATEX_OPTIONS = -interaction=nonstopmode
# specify LaTeX options
LATEX_RUNS = 1

.PHONY : all
all:
	@echo Making: $(CHARACTER_NAMES)
	$(MAKE) $(CHARACTER_NAMES)

$(CHARACTERS_DIR)/%.m4:
	$(error $(@) missing !)

$(CHARACTERS_DIR)/%.inc:
	$(warning $(@) missing !)

$(CHARACTERS_DIR)/%.anm:
	$(warning $(@) missing !)


%.tex: $(CHARACTERS_DIR)/%.m4 $(CHARACTERS_DIR)/%.inc $(CHARACTERS_DIR)/%.anm
	# Link sources to working dir
ifneq ($(CHARACTERS_DIR),.)
	if [ -L $(basename $(@)).m4 ]; then rm $(basename $(@)).m4; fi
	ln -s $(CHARACTERS_DIR)/$(basename $(@)).m4 $(basename $(@)).m4
	if [ -L $(basename $(@)).inc ]; then rm $(basename $(@)).inc; fi
	ln -s $(CHARACTERS_DIR)/$(basename $(@)).inc $(basename $(@)).inc
	if [ -L $(basename $(@)).anm ]; then rm $(basename $(@)).anm; fi
	ln -s $(CHARACTERS_DIR)/$(basename $(@)).anm $(basename $(@)).anm
endif
	m4 -I$(RULES_DIR) -Dchar_filename=`echo $(@) | sed -e's/char_\([a-z]*\)\.tex/\1/'` < $(<) > $(@)

	# Remove links
ifneq ($(CHARACTERS_DIR),.)
	if [ -L $(basename $(@)).m4 ]; then rm $(basename $(@)).m4; fi
	if [ -L $(basename $(@)).inc ]; then rm $(basename $(@)).inc; fi
	if [ -L $(basename $(@)).anm ]; then rm $(basename $(@)).anm; fi
endif


%.dvi: %.tex
	for (( i=0 ; i<$(LATEX_RUNS) ; i=i+1 )) ; do \
		latex $(LATEX_OPTIONS) $(<) ; \
	done
	if [ -e $(basename $(@)).log ]; then rm $(basename $(@)).log; fi
	if [ -e $(basename $(@)).aux ]; then rm $(basename $(@)).aux; fi

%.ps: %.dvi
	dvips -t a4 -o $(@) $(<)

%.ps.gz: %.ps
	gzip --best -f $(<)

%.pdf: %.tex
	for (( i=0 ; i<$(LATEX_RUNS) ; i=i+1 )) ; do \
		pdflatex $(LATEX_OPTIONS) $(<) ; \
	done
	if [ -e $(basename $(@)).log ]; then rm $(basename $(@)).log; fi
	if [ -e $(basename $(@)).aux ]; then rm $(basename $(@)).aux; fi


# This creates phony targets in order to be able to request
#   make <name>   and get char_<name>.<DEFAULT_FORMAT>

CHARACTER_NAMES := $(patsubst $(CHARACTERS_DIR)/char_%.m4,%,$(wildcard $(CHARACTERS_DIR)/char_*.m4))
DEFAULT_FORMAT = pdf

.PHONY : $(CHARACTER_NAMES)


$(CHARACTER_NAMES): %: char_%.$(DEFAULT_FORMAT)
	@echo making: $(<)
	make $(<)

# Default:


# clean tex temporary files

.PHONY : clean

clean:
	rm -f *.aux
	rm -f *.__inc
	rm -f *.__m4
	rm -f *.dvi
	rm -f *.log
	rm -f *.pdf
	rm -f *.ps
	rm -f *.ps.gz
	rm -f *.tex

.PHONY : help

help:
	@echo 
	@echo "Use "
	@echo "  make <name>                to render <name> in format .$(DEFAULT_FORMAT)"
	@echo "  make char_<name>.<format>  to render other formats"
	@echo 
	@echo "The rules directory is"
	@echo "  $(RULES_DIR) ->" `readlink -f $(RULES_DIR)`
	@echo 
	@echo "The characters are in"  
	@echo "  $(CHARACTERS_DIR) ->" `readlink -f $(CHARACTERS_DIR)`
	@echo 
	@echo "The folling characters are available: " 
	@echo "  $(CHARACTER_NAMES)"
	@echo 
