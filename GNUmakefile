###########################################################################
#                                GNUmakefile
#                            -------------------    
#   Makefile for the Fittino program
#                            -------------------
#   $Id$
#   $Name$
#                            -------------------
#   begin                : September 14, 2003
#   authors              : Philip Bechtle, Peter Wienemann
#   email                : philip.bechtle@desy.de, peter.wienemann@desy.de
###########################################################################

###########################################################################
#                                                                         #
#   This program is free software; you can redistribute it and/or modify  #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation; either version 2 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
###########################################################################

ARCH              = $(shell uname)

ROOTCFLAGS        = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS          = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTLIBS         += -lMinuit
ROOTGLIBS         = $(shell $(ROOTSYS)/bin/root-config --glibs)


CXX               = g++
CXXFLAGS          = -g -Wall -pedantic -Wno-long-long \
                    -Wshadow -fPIC -I. $(ROOTCFLAGS) 
LD                = g++
LDFLAGS           = -g -Wall -pedantic -Wno-long-long -Wshadow
# -pedantic -ansi

LIBS              = $(ROOTLIBS)

SOURCES           = $(wildcard *.cpp)
OBJECTS_BASENAME  = $(SOURCES:.cpp=.o)
OBJECTS_BASENAME += lex.yy.o y.tab.o
INCLUDES          = $(wildcard *.h)
DEPENDS_BASENAME  = $(SOURCES:.cpp=.d)

TARGET            = fittino

all: 	$(TARGET)

## Include dependency files
-include $(SOURCES:.cpp=.d)

%.d: %.cpp
	@echo Generating dependency file ---------- $@ ----------
	@$(SHELL) -ec '$(CXX) -MM $(CXXFLAGS) $< \
	              | sed '\''s/\($*\)\.o[ :]*/\1.o $@ : /g'\'' > $@; \
	              [ -s $@ ] || rm -f $@'
#	-rm -f $@
#	$(CXX) -MM $(CXXFLAGS) $< > $@ 

fittino: $(OBJECTS_BASENAME) 
	$(CXX) -o fittino $(LDFLAGS) $(OBJECTS_BASENAME) $(LIBS)


%.o: %.cpp 
	$(CXX) -c -o $@ $< $(CXXFLAGS)

lex.yy.o: y.tab.c lex.yy.c
	gcc -I. -c -o lex.yy.o lex.yy.c

y.tab.o:  y.tab.c lex.yy.c
	$(CXX) $(CXXFLAGS) -c -o y.tab.o y.tab.c

lex.yy.c: readvalues.lex y.tab.c
	lex -i readvalues.lex 
y.tab.c: readvalues.yacc 
	yacc -d readvalues.yacc

libsusygen_call_test.a: susygen_call_test.f
	fort susygen_call_test.f
	ar -ruc libsusygen_call_test.a susygen_call_test.o

clean:
	-rm -f *.o *.d *~ lex.yy.c y.tab.h y.tab.c fittino
