SET( subroutine "subroutine finish_HiggsSignals_only
!------------------------------------------------------------
 use datatables, only : deallocate_observables
 use usefulbits_HS, only : deallocate_usefulbits_HS, analyses
 use mc_chisq, only : deallocate_mc_observables
 use store_pathname_HS

call deallocate_mc_observables
call deallocate_observables
if(allocated(analyses)) deallocate(analyses)
call deallocate_usefulbits_HS
call system('rm -f HS_analyses.txt')

end subroutine finish_HiggsSignals_only
!------------------------------------------------------------")
FILE( READ HiggsSignals_subroutines.F90 srcfile ) 
STRING( FIND "${srcfile}" "subroutine finish_HiggsSignals_only" pos )
IF( pos EQUAL -1 )
FILE( APPEND HiggsSignals_subroutines.F90 ${subroutine} )
ENDIF()

FILE( READ create_store_pathname_HS.bat fileContent )
STRING( REPLACE "startdir=`pwd -P`" "startdir=${DATADIR}/HiggsSignals" fileContent ${fileContent} )
FILE ( WRITE create_store_pathname.bat ${fileContent} )
