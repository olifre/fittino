modname = MSSMTriLnV  # as an example  
PreDef = -DGENERATIONMIXING -DONLYDOUBLE
# setting various paths  
InDir = ../include
Mdir = ${InDir}
VPATH = 3-Body-Decays:LoopDecays:TwoLoopMasses:Observables:SM 
name = ../lib/libSPhenoMSSMTriLnV.a
 
# check if SARAH module and SPheno are compatibel  
minV=330.00 
cVersion =$(shell expr $(version) \>= $(minV))
#  
# options for various compilers  
#  
# Default Compiler  
F90=gfortran
comp= -c -O -module ${Mdir} -I${InDir}  
LFlagsB= -O  
# Intels ifort,debug modus  
ifeq (${F90},ifortg)  
F90=ifort  
comp= -c -g -module ${Mdir} -I${InDir}  
LFlagsB= -g  
endif  
# gfortran  
ifeq (${F90},gfortran)  
comp= -c -g -ffree-line-length-none -J${Mdir} -I${InDir}  
LFlagsB= -g  
endif  
# g95  
ifeq (${F90},g95)  
comp= -c -O -fmod=${Mdir} -I${InDir}  
LFlagsB= -O  
endif  
# Lahey F95 compiler  
ifeq (${F90},lf95)  
comp=-c -O -M ${Mdir} -I${InDir}  
LFlagsB=-O  
endif  
# NAG f95/2003  
ifeq (${F90},nagfor)  
comp= -c -O -mdir ${Mdir} -I${InDir}  
LFlagsB= -O -DONLYDOUBLE -mdir ${MDir} -I${InDir}  
endif   
.SUFFIXES : .o .ps .f90 .F90 .a 
bin/SPhenoMSSMTriLnV:
ifeq (${cVersion},1)
	 cd ../src ; ${MAKE} F90=${F90} 
	 ${MAKE} F90=${F90} ${name} 
	 ${MAKE} F90=${F90} SPhenoMSSMTriLnV.o 
	 ${F90} -c TwoLoopMasses/effpotasat.f 
	 ${F90} -o SPhenoMSSMTriLnV ${LFlagsB} SPhenoMSSMTriLnV.o effpotasat.o ../lib/libSPhenoMSSMTriLnV.a ../lib/libSPheno.a
	 mv SPhenoMSSMTriLnV ../bin
	 rm SPhenoMSSMTriLnV.o  
${name}:  ${name}(Settings.o) ${name}(Model_Data_MSSMTriLnV.o)  \
 ${name}(RGEs_MSSMTriLnV.o)   \
 ${name}(Couplings_MSSMTriLnV.o) ${name}(TreeLevelMasses_MSSMTriLnV.o) ${name}(TadpoleEquations_MSSMTriLnV.o) \
 ${name}(LoopCouplings_MSSMTriLnV.o) ${name}(CouplingsForDecays_MSSMTriLnV.o) \
 ${name}(TreeLevel_Decays_MSSMTriLnV.o) \
 ${name}(Glu_MSSMTriLnV.o)  ${name}(Chi_MSSMTriLnV.o)  ${name}(Cha_MSSMTriLnV.o)  ${name}(Sd_MSSMTriLnV.o)  ${name}(Su_MSSMTriLnV.o)  ${name}(Se_MSSMTriLnV.o)  ${name}(Sv_MSSMTriLnV.o)  \
 ${name}(EffPotFunctions.o) ${name}(DerivativesEffPotFunctions.o) ${name}(EffectivePotential_MSSMTriLnV.o) \
 ${name}(2LPoleFunctions.o) ${name}(2LPole_MSSMTriLnV.o) \
 ${name}(TwoLoopHiggsMass_SARAH.o) \
${name}(AddLoopFunctions.o) ${name}(Kinematics.o) \
 ${name}(LoopMasses_MSSMTriLnV.o) \
 ${name}(RGEs_SM_HC.o) ${name}(Couplings_SM_HC.o) ${name}(TreeLevelMasses_SM_HC.o) ${name}(LoopMasses_SM_HC.o)   \
 ${name}(BranchingRatios_MSSMTriLnV.o) ${name}(HiggsCS_MSSMTriLnV.o) ${name}(RunSM_MSSMTriLnV.o) \
 ${name}(LowEnergy_MSSMTriLnV.o) \
${name}(FlavorKit_LFV_MSSMTriLnV.o) ${name}(FlavorKit_QFV_MSSMTriLnV.o) ${name}(FlavorKit_Observables_MSSMTriLnV.o)\
 ${name}(Boundaries_MSSMTriLnV.o)  ${name}(InputOutput_MSSMTriLnV.o) 
else 
	 @echo -------------------------------------------------------------------  
	 @echo ERROR:  
	 @echo The installed SPheno is version not compatibel with this module 
	 @echo Please, upgrade at least to SPheno version 3.3.0.  
	 @echo The current SPheno version can be downloaded from 
	 @echo http://www.hepforge.org/downloads/spheno 
	 @echo ------------------------------------------------------------------- 
endif 
clean: 
	 rm -f *.o *~ */*.o */*~
cleanall: 
	 rm -f bin/SPheno3 lib/*.a *~ */*.o */*~ include/*
#
# Suffix rules
#
.f90.a:
	 ${F90} ${comp} $< 
	 ar -ruc $@ $*.o
	 rm -f $*.o
.F90.a:
	 ${F90} ${comp} ${PreDef} $< 
	 ar -ruc $@ $*.o
	 rm -f $*.o
.f90.o:
	 ${F90} ${comp} $<
.f90.ps:
	 a2ps -o $*.ps $<
.h.ps:
	 a2ps -o $*.ps $<
