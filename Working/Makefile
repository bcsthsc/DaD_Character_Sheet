# Makefile to translate m4 character sheets into ps, dvi or pdf
# You can put this into a "working" directory or directly into your 
# "characters" directory.

#.SILENT:


# specify the rules base directory
RULES_DIR = ../Rules
# specify the character sources directory
CHARACTERS_DIR = ../Characters


.PHONY : all
all:
	@echo Making: $(CHARACTER_NAMES)
	$(MAKE) $(CHARACTER_NAMES)



%.__m4: $(CHARACTERS_DIR)/%.m4
	if [ -L $(@) ]; then rm $(@); fi
	ln -s $(<) $(@)

%.__inc: $(CHARACTERS_DIR)/%.inc
	if [ -L $(@) ]; then rm $(@); fi
	ln -s $(<) $(@)
	if [ -L $(notdir $(<)) ]; then rm $(notdir $(<)); fi
	ln -s $(<) $(notdir $(<))
	if [ -e $(basename $(<)).anm ]; then ln -s $(basename $(<)).anm $(notdir $(basename $(<)).anm); fi

%.tex: %.__m4 %.__inc
	m4 -I$(RULES_DIR) -Dchar_filename=`echo $(<) | sed -e's/char_\([a-z]*\)\.__m4/\1/'` < $(<) > $(@)
	if [ -L $(basename $(@)).inc ]; then rm $(basename $(@)).inc; fi
	if [ -L $(basename $(@)).anm ]; then rm $(basename $(@)).anm; fi


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

CHARACTER_NAMES := $(patsubst $(CHARACTERS_DIR)/char_%.m4,%,$(wildcard $(CHARACTERS_DIR)/char_*.m4))
DEFAULT_FORMAT = pdf

.PHONY : $(CHARACTER_NAMES)


$(CHARACTER_NAMES): %: char_%.$(DEFAULT_FORMAT)
	@echo making: $(<)
	make $(<)

#	@echo Target: $(@) "^" $(^) "<" $(<) ">" $(>) "+" $(+) "?" $(?) "%" $(%) "*" $(*)
#	@echo CHARACTER_NAMES = $(CHARACTER_NAMES)
#	for name in $(CHARACTER_NAMES); do \
#		echo "->" make char_$${name}.$(DEFAULT_FORMAT); \
#		make char_$${name}.$(DEFAULT_FORMAT); \
#	done

# Default:


# clean tex temporary files

.PHONY : clean

clean:
	rm -f *.aux
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
