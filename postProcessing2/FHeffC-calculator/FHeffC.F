c------------------------------------------------------------------------
      program FHeffC
c------------------------------------------------------------------------
c This program calculates squared (SM normalized) effective Higgs couplings
c using FeynHiggs for a MSSM model point. It gives the results both for 
c internal (UHIGGS) and external (ZHIGGS) Higgs bosons. Also, the SM 
c partial widths for the corresponding Higgs decay are given for every
c effective couplings (if it exists). In addition, the total width and
c the production cross sections (LHC at 8TeV) are given for both the model
c point and the SM. (TS, 17/05/2013)
c------------------------------------------------------------------------
        implicit none

        integer error

c used by FHHiggsCorr
        double precision MHiggs(4)
        double complex SAeff, DeltaSAeff, UHiggs(3,3), ZHiggs(3,3)

c used by FHSelectUZ:
        integer uzint, uzext, mfeff

c used by FHCouplings:
#include "FHCouplings.h"
        double complex couplings(ncouplings), couplingsms(ncouplingsms)
        double precision gammas(ngammas), gammasms(ngammasms)
        double precision GammaTot, GammaSMTot
        integer fast

c used by FHHiggsProd:
        double precision sqrts, prodxs(nprodxs)

c used by FHGetPara:
        integer nmfv
        double precision MASf(6,4), MCha(2), MNeu(4)
        double complex UASf(6,6,4)
        double complex UCha(2,2), VCha(2,2), ZNeu(4,4)
        double complex DeltaMB
        double precision MGl
        double precision MHtree(4), SAtree

c used by FHRetrieveSMPara: 
        double precision invAlfa, AlfasMZ, GF
        double precision ME, MU, MD, MM, MC, MS, ML, MB
        double precision MW, MZ
        double precision CKMlambda, CKMA, CKMrhobar, CKMetabar

#include "SLHA.h"

#include "PDG.h"
        integer parent

c used by FHSetSLHA,FHOutputSLHA
        integer key
        double complex slhadata(nslhadata)
c        character*(*) inputfile = "SPheno.spc"
c        character*(*) outputfile = "SPheno.spc.fh"

c define effective Higgs couplings: Entries: (1) UHiggs, (2) ZHiggs, (3) SM partial width
        double precision g2hWW(4),g2hZZ(4),g2hgg(4)
        double precision g2hggZ(4),g2hgaga(4),g2hZga(4)
        double precision g2hbb_s(4),g2hbb_p(4)
        double precision g2htautau_s(4),g2htautau_p(4)
        double precision g2htoptop_s(4),g2htoptop_p(4)
        double precision g2hss_s(4),g2hss_p(4)
        double precision g2hmumu_s(4),g2hmumu_p(4)
        double precision g2hcc_s(4),g2hcc_p(4)
        double precision GammaTotFH, SMGammaTotFH, Gammahneut1neut1
        double precision SMgghFH, SMbbhFH, SMqqhFH, SMWhFH, SMZhFH, SMtthFH 
        double precision gghFH, ggh2FH, bbhFH, btagbhFH, qqhFH, WhFH, ZhFH, tthFH 
        double precision SMbtagbhFH, StSthFH, tHmFH

        call FHSetFlagsString(error, "400202110")
        if( error .ne. 0 ) return
        
        call SLHARead(error, slhadata, "SPheno.spc", 1)
        if( error .ne. 0 ) return

        call FHSetSLHA(error, slhadata)
        if( error .ne. 0 ) return

        call FHSetDebug(0)
  
        call FHHiggsCorr(error, MHiggs, SAeff, UHiggs, ZHiggs)
        if( error .ne. 0 ) return
	
        call FHSelectUZ(error, 1, 1, 1)
    	
        if( error .ne. 0 ) return

        call FHCouplings(error,couplings,couplingsms,gammas,gammasms,1)
        if( error .ne. 0 ) return

c turn all of them on i.e. 255=1+2+4+8+16+32+64+128
        key=255 

        call FHOutputSLHA(error, slhadata, key)
        if( error .ne. 0 ) return

        call SLHAWrite(error, slhadata, "SPheno.spc.fh")
        if( error .ne. 0 ) return

        call couplingsfromFH
        if( error .ne. 0 ) return

        open(UNIT=123,FILE="effectivecouplings_UHiggs.dat")

        write(123,'(A1,1X,A15,1X,A20,1X,A19,1X,A19,1X,A20)') "#","Coupling","FHCoup","Gamma/SM","SMGamma","SMg2val"
        write(123,'(A1)') '#'
        write(123,'(2X,A15,1X,4F20.10)') "g2hWW", g2hWW
        write(123,'(2X,A15,1X,4F20.10)') "g2hZZ", g2hZZ
        write(123,'(2X,A15,1X,4F20.10)') "g2hgg", g2hgg
        write(123,'(2X,A15,1X,4F20.10)') "g2hgaga", g2hgaga
        write(123,'(2X,A15,1X,4F20.10)') "g2hZga", g2hZga
        write(123,'(2X,A15,1X,4F20.10)') "g2hggZ", g2hggZ        
        write(123,'(2X,A15,1X,4F20.10)') "g2hbb_s", g2hbb_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hbb_p", g2hbb_p
        write(123,'(2X,A15,1X,4F20.10)') "g2htautau_s", g2htautau_s
        write(123,'(2X,A15,1X,4F20.10)') "g2htautau_p", g2htautau_p
        write(123,'(2X,A15,1X,4F20.10)') "g2htoptop_s", g2htoptop_s
        write(123,'(2X,A15,1X,4F20.10)') "g2htoptop_p", g2htoptop_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hss_s", g2hss_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hss_p", g2hss_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hmumu_s", g2hmumu_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hmumu_p", g2hmumu_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hcc_s", g2hcc_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hcc_p", g2hcc_p
        write(123,'(A1)') '#'
        write(123,'(A1,1X,A15,1X,A20,1X,A19)')'#','Rate(8TeV)','Model','SM' 
        write(123,'(A1)') '#'
        write(123,'(2X,A15,1X,1F20.10)') "G(h->n1n1)", Gammahneut1neut1
        write(123,'(2X,A15,1X,2F20.10)') "GTot", GammaTotFH,SMGammaTotFH
        write(123,'(2X,A15,1X,2F20.10)') "ggh", gghFH,SMgghFH
        write(123,'(2X,A15,1X,1F20.10)') "ggh2", ggh2FH
        write(123,'(2X,A15,1X,2F20.10)') "bbh", bbhFH,SMbbhFH
        write(123,'(2X,A15,1X,2F20.10)') "btagbh", btagbhFH,SMbtagbhFH        
        write(123,'(2X,A15,1X,2F20.10)') "qqh", qqhFH,SMqqhFH
        write(123,'(2X,A15,1X,2F20.10)') "Wh",WhFH,SMWhFH  
        write(123,'(2X,A15,1X,2F20.10)') "Zh",ZhFH,SMZhFH  
        write(123,'(2X,A15,1X,2F20.10)') "tth",tthFH,SMtthFH 
        write(123,'(2X,A15,1X,1F20.10)') "StSth",StSthFH
        write(123,'(2X,A15,1X,1F20.10)') "tHmFH",tHmFH

        close(123)

        call FHSelectUZ(error, 2, 2, 1)
    	
        if( error .ne. 0 ) return

        call FHCouplings(error,couplings,couplingsms,gammas,gammasms,1)
        if( error .ne. 0 ) return

c turn all of them on i.e. 255=1+2+4+8+16+32+64+128
        key=255 

        call FHOutputSLHA(error, slhadata, key)
        if( error .ne. 0 ) return

c        call SLHAWrite(error, slhadata, "SPheno.spc.fh-ZHiggs")
        if( error .ne. 0 ) return

        call couplingsfromFH
        if( error .ne. 0 ) return

        open(UNIT=123,FILE="effectivecouplings_ZHiggs.dat")

        write(123,'(A1,1X,A15,1X,A20,1X,A19,1X,A19,1X,A20)') "#","Coupling","FHCoup","Gamma/SM","SMGamma","SMg2val"
        write(123,'(A1)') '#'
        write(123,'(2X,A15,1X,4F20.10)') "g2hWW", g2hWW
        write(123,'(2X,A15,1X,4F20.10)') "g2hZZ", g2hZZ
        write(123,'(2X,A15,1X,4F20.10)') "g2hgg", g2hgg
        write(123,'(2X,A15,1X,4F20.10)') "g2hgaga", g2hgaga
        write(123,'(2X,A15,1X,4F20.10)') "g2hZga", g2hZga
        write(123,'(2X,A15,1X,4F20.10)') "g2hggZ", g2hggZ        
        write(123,'(2X,A15,1X,4F20.10)') "g2hbb_s", g2hbb_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hbb_p", g2hbb_p
        write(123,'(2X,A15,1X,4F20.10)') "g2htautau_s", g2htautau_s
        write(123,'(2X,A15,1X,4F20.10)') "g2htautau_p", g2htautau_p
        write(123,'(2X,A15,1X,4F20.10)') "g2htoptop_s", g2htoptop_s
        write(123,'(2X,A15,1X,4F20.10)') "g2htoptop_p", g2htoptop_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hss_s", g2hss_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hss_p", g2hss_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hmumu_s", g2hmumu_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hmumu_p", g2hmumu_p
        write(123,'(2X,A15,1X,4F20.10)') "g2hcc_s", g2hcc_s
        write(123,'(2X,A15,1X,4F20.10)') "g2hcc_p", g2hcc_p
        write(123,'(A1)') '#'
        write(123,'(A1,1X,A15,1X,A20,1X,A19)')'#','Rate(8TeV)','Model','SM' 
        write(123,'(A1)') '#'
        write(123,'(2X,A15,1X,1F20.10)') "G(h->n1n1)", Gammahneut1neut1
        write(123,'(2X,A15,1X,2F20.10)') "GTot", GammaTotFH,SMGammaTotFH
        write(123,'(2X,A15,1X,2F20.10)') "ggh", gghFH,SMgghFH
        write(123,'(2X,A15,1X,1F20.10)') "ggh2", ggh2FH
        write(123,'(2X,A15,1X,2F20.10)') "bbh", bbhFH,SMbbhFH
        write(123,'(2X,A15,1X,2F20.10)') "btagbh", btagbhFH,SMbtagbhFH        
        write(123,'(2X,A15,1X,2F20.10)') "qqh", qqhFH,SMqqhFH
        write(123,'(2X,A15,1X,2F20.10)') "Wh",WhFH,SMWhFH  
        write(123,'(2X,A15,1X,2F20.10)') "Zh",ZhFH,SMZhFH  
        write(123,'(2X,A15,1X,2F20.10)') "tth",tthFH,SMtthFH 
        write(123,'(2X,A15,1X,1F20.10)') "StSth",StSthFH
        write(123,'(2X,A15,1X,1F20.10)') "tHmFH",tHmFH 

        close(123)


c       end
c---------------------------------------------------------
c---------------------------------------------------------
       contains
c-------------------------------------------------------------------
c-------------------------------------------------------------------
       subroutine couplingsfromFH

c used by FHHiggsProd:
        double precision sqrts, prodxs(nprodxs)

c misc:
        integer i,j
        double precision norm,CW2,Pi
        Pi = 3.1415926535897932384626433832795029D0

c We would like FH to calculate LHC cross sections
        sqrts=8.0D0
        call FHHiggsProd(error, sqrts, prodxs)
        if( error .ne. 0 ) return

        call FHRetrieveSMPara(error,
     &   invAlfa, AlfasMZ, GF,
     &   ME, MU, MD, MM, MC, MS, ML, MB,
     &   MW, MZ,
     &   CKMlambda, CKMA, CKMrhobar, CKMetabar)
        if( error .ne. 0 ) return
    
         g2hbb_s(1)=(abs(RCoupling(H0FF(1,4,3,3))
     &                   /RCouplingSM(H0FF(1,4,3,3))+ 
     &                    LCoupling(H0FF(1,4,3,3))
     &                   /LCouplingSM(H0FF(1,4,3,3)))/2.0D0)**2.0D0
     
         g2hbb_p(1)=(abs(RCoupling(H0FF(1,4,3,3))
     &                   /RCouplingSM(H0FF(1,4,3,3))- 
     &                    LCoupling(H0FF(1,4,3,3))
     &                   /LCouplingSM(H0FF(1,4,3,3)))/2.0D0)**2.0D0

         g2hbb_s(2)= Gamma(H0FF(1,4,3,3))/GammaSM(H0FF(1,4,3,3))
         g2hbb_s(3)= GammaSM(H0FF(1,4,3,3))
         g2hbb_p(2)= 0.0D0
         g2hbb_p(3)= 0.0D0        
         g2hbb_s(4)=(abs(RCouplingSM(H0FF(1,4,3,3))+ 
     &                   LCouplingSM(H0FF(1,4,3,3)))/2.0D0)**2.0D0
         g2hbb_p(4)=0.0D0
         
         g2htautau_s(1)=(abs(RCoupling(H0FF(1,2,3,3))
     &                   /RCouplingSM(H0FF(1,2,3,3))+ 
     &                    LCoupling(H0FF(1,2,3,3))
     &                   /LCouplingSM(H0FF(1,2,3,3)))/2.0D0)**2.0D0
         g2htautau_p(1)=(abs(RCoupling(H0FF(1,2,3,3))
     &                   /RCouplingSM(H0FF(1,2,3,3))- 
     &                    LCoupling(H0FF(1,2,3,3))
     &                   /LCouplingSM(H0FF(1,2,3,3)))/2.0D0)**2.0D0

         g2htautau_s(2)= Gamma(H0FF(1,2,3,3))/GammaSM(H0FF(1,2,3,3))
         g2htautau_p(2)= 0.0D0
         g2htautau_s(3)=GammaSM(H0FF(1,2,3,3))
         g2htautau_p(3)= 0.0D0
         g2htautau_s(4)=(abs(RCouplingSM(H0FF(1,2,3,3))+ 
     &                   LCouplingSM(H0FF(1,2,3,3)))/2.0D0)**2.0D0
         g2htautau_p(4)=0.0D0


         g2htoptop_s(1)=(abs(RCoupling(H0FF(1,3,3,3))
     &                   /RCouplingSM(H0FF(1,3,3,3))+ 
     &                    LCoupling(H0FF(1,3,3,3))
     &                   /LCouplingSM(H0FF(1,3,3,3)))/2.0D0)**2.0D0
         g2htoptop_p(1)=(abs(RCoupling(H0FF(1,3,3,3))
     &                   /RCouplingSM(H0FF(1,3,3,3))- 
     &                    LCoupling(H0FF(1,3,3,3))
     &                   /LCouplingSM(H0FF(1,3,3,3)))/2.0D0)**2.0D0
         g2htoptop_s(4)=(abs(RCouplingSM(H0FF(1,3,3,3))+ 
     &                   LCouplingSM(H0FF(1,3,3,3)))/2.0D0)**2.0D0
         g2htoptop_p(4)=0.0D0
         
         if(tthSM(1).gt.0.0D0) then
          g2htoptop_s(2)= tth(1)/tthSM(1)
          g2htoptop_s(3)=GammaSM(H0FF(1,3,3,3))
         else 
          g2htoptop_s(2) = 0.0D0
         endif
         g2htoptop_p(2)= 0.0D0
         g2htoptop_p(3)= 0.0D0

         g2hss_s(1)=(abs(RCoupling(H0FF(1,4,2,2))
     &                   /RCouplingSM(H0FF(1,4,2,2))+ 
     &                    LCoupling(H0FF(1,4,2,2))
     &                   /LCouplingSM(H0FF(1,4,2,2)))/2.0D0)**2.0D0
         g2hss_p(1)=(abs(RCoupling(H0FF(1,4,2,2))
     &                   /RCouplingSM(H0FF(1,4,2,2))- 
     &                    LCoupling(H0FF(1,4,2,2))
     &                   /LCouplingSM(H0FF(1,4,2,2)))/2.0D0)**2.0D0

         g2hss_s(2)= Gamma(H0FF(1,4,2,2))/GammaSM(H0FF(1,4,2,2))
         g2hss_p(2)= 0.0D0
         g2hss_s(3)= GammaSM(H0FF(1,4,2,2))
         g2hss_p(3)= 0.0D0
         g2hss_s(4)=(abs(RCouplingSM(H0FF(1,4,2,2))+ 
     &                   LCouplingSM(H0FF(1,4,2,2)))/2.0D0)**2.0D0
         g2hss_p(4)=0.0D0


         g2hmumu_s(1)=(abs(RCoupling(H0FF(1,2,2,2))
     &                   /RCouplingSM(H0FF(1,2,2,2))+ 
     &                    LCoupling(H0FF(1,2,2,2))
     &                   /LCouplingSM(H0FF(1,2,2,2)))/2.0D0)**2.0D0
         g2hmumu_p(1)=(abs(RCoupling(H0FF(1,2,2,2))
     &                   /RCouplingSM(H0FF(1,2,2,2))- 
     &                    LCoupling(H0FF(1,2,2,2))
     &                   /LCouplingSM(H0FF(1,2,2,2)))/2.0D0)**2.0D0

         g2hmumu_s(2)= Gamma(H0FF(1,2,2,2))/GammaSM(H0FF(1,2,2,2))
         g2hmumu_p(2)= 0.0D0
         g2hmumu_s(3)= GammaSM(H0FF(1,2,2,2))
         g2hmumu_p(3)= 0.0D0
         g2hmumu_s(4)=(abs(RCouplingSM(H0FF(1,2,2,2))+ 
     &                   LCouplingSM(H0FF(1,2,2,2)))/2.0D0)**2.0D0
         g2hmumu_p(4)=0.0D0

         
         g2hcc_s(1)=(abs(RCoupling(H0FF(1,3,2,2))
     &                   /RCouplingSM(H0FF(1,3,2,2))+ 
     &                    LCoupling(H0FF(1,3,2,2))
     &                   /LCouplingSM(H0FF(1,3,2,2)))/2.0D0)**2.0D0
         g2hcc_p(1)=(abs(RCoupling(H0FF(1,3,2,2))
     &                   /RCouplingSM(H0FF(1,3,2,2))- 
     &                    LCoupling(H0FF(1,3,2,2))
     &                   /LCouplingSM(H0FF(1,3,2,2)))/2.0D0)**2.0D0

         g2hcc_s(2)= Gamma(H0FF(1,3,2,2))/GammaSM(H0FF(1,3,2,2))
         g2hcc_p(2)= 0.0D0         
         g2hcc_s(3)=GammaSM(H0FF(1,3,2,2))
         g2hcc_p(3)= 0.0D0
         g2hcc_s(4)=(abs(RCouplingSM(H0FF(1,3,2,2))+ 
     &                   LCouplingSM(H0FF(1,3,2,2)))/2.0D0)**2.0D0
         g2hcc_p(4)=0.0D0

         
         g2hgaga(1)= dble(  Coupling(H0VV(1,1)) 
     &                   / CouplingSM(H0VV(1,1)) )**2.0D0
     &            + dimag( Coupling(H0VV(1,1)) 
     &                   / CouplingSM(H0VV(1,1)) )**2.0D0

         g2hgaga(2) = Gamma(H0VV(1,1))/GammaSM(H0VV(1,1))
         g2hgaga(3) = GammaSM(H0VV(1,1))
         g2hgaga(4)= dble(CouplingSM(H0VV(1,1)) )**2.0D0
     &            + dimag(CouplingSM(H0VV(1,1)) )**2.0D0

         g2hZga(1)= dble(  Coupling(H0VV(1,2)) 
     &                   / CouplingSM(H0VV(1,2)) )**2.0D0
     &            + dimag( Coupling(H0VV(1,2)) 
     &                   / CouplingSM(H0VV(1,2)) )**2.0D0
         g2hZga(2) = Gamma(H0VV(1,2))/GammaSM(H0VV(1,2))
         g2hZga(3) = GammaSM(H0VV(1,2))
         g2hZga(4)= dble(CouplingSM(H0VV(1,2)) )**2.0D0
     &           + dimag(CouplingSM(H0VV(1,2)) )**2.0D0
         

         g2hZZ(1)= dble(  Coupling(H0VV(1,3)) 
     &                   / CouplingSM(H0VV(1,3)) )**2.0D0
     &            + dimag( Coupling(H0VV(1,3)) 
     &                   / CouplingSM(H0VV(1,3)) )**2.0D0

         g2hZZ(2) = Gamma(H0VV(1,3))/GammaSM(H0VV(1,3))
         g2hZZ(3) = GammaSM(H0VV(1,3))
         g2hZZ(4)= dble(CouplingSM(H0VV(1,3)) )**2.0D0
     &            + dimag(CouplingSM(H0VV(1,3)) )**2.0D0


         g2hWW(1)= dble(  Coupling(H0VV(1,4)) 
     &                   / CouplingSM(H0VV(1,4)) )**2.0D0
     &            + dimag( Coupling(H0VV(1,4)) 
     &                   / CouplingSM(H0VV(1,4)) )**2.0D0

         g2hWW(2) = Gamma(H0VV(1,4))/GammaSM(H0VV(1,4))
         g2hWW(3) = GammaSM(H0VV(1,4))
         g2hWW(4)= dble(CouplingSM(H0VV(1,4)) )**2.0D0
     &            + dimag(CouplingSM(H0VV(1,4)) )**2.0D0


         g2hgg(1)= dble(  Coupling(H0VV(1,5)) 
     &                   / CouplingSM(H0VV(1,5)) )**2.0D0
     &            + dimag( Coupling(H0VV(1,5)) 
     &                   / CouplingSM(H0VV(1,5)) )**2.0D0

         g2hgg(2) = Gamma(H0VV(1,5))/GammaSM(H0VV(1,5))
         g2hgg(3) = GammaSM(H0VV(1,5))
         g2hgg(4)= dble(CouplingSM(H0VV(1,5)) )**2.0D0
     &            + dimag(CouplingSM(H0VV(1,5)) )**2.0D0


         GammaTotFH = GammaTot(1)
         SMGammaTotFH = GammaSMTot(1)         

         g2hggZ(1)=0.0D0
         g2hggZ(2)=0.0D0
         g2hggZ(3)=0.0D0
  
         Gammahneut1neut1 = Gamma(H0NeuNeu(1,1,1))
  
         SMgghFH = gghSM(1)
!         SMggh2FH = ggh2SM(1)
         SMbbhFH = bbhSM(1)
         SMbtagbhFH = btagbhSM(1)
         SMqqhFH = qqhSM(1)
         SMWhFH  = WhSM(1)
         SMZhFH  = ZhSM(1)
         SMtthFH = tthSM(1)

         gghFH = ggh(1)
         ggh2FH = ggh2(1)
         bbhFH = bbh(1)
         btagbhFH = btagbh(1)
         qqhFH = qqh(1)
         WhFH  = Wh(1)
         ZhFH  = Zh(1)
         tthFH = tth(1)
         StSthFH = StSth(1)
         tHmFH = tHm
    
       end subroutine
      end program