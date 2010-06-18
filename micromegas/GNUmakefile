MAINDIR = /lustre/user/wiene/theorycodes/NPFitter.mm2.2
MGMLIBDIR = $(MAINDIR)/micromegas_2.2.CPC.i
MOMGLIBS = $(MGMLIBDIR)/sources/micromegas.a $(MGMLIBDIR)/MSSM/lib/aLib.a \
           $(MGMLIBDIR)/MSSM/work/work_aux.a $(MGMLIBDIR)/CalcHEP_src/lib/model_aux.so \
           $(MGMLIBDIR)/CalcHEP_src/lib/sqme_aux.so

CXXFLAGS += -I$(MGMLIBDIR)/MSSM/lib -I$(MGMLIBDIR)/sources

include $(MGMLIBDIR)/CalcHEP_src/FlagsForMake
cLib = $(CALCHEP)/lib

all: micromegas.cpp
	$(CXX) $(CXXFLAGS) micromegas.cpp -o micromegas $(MOMGLIBS) $(lDL) -lm