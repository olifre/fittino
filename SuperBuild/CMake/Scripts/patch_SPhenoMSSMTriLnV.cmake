
if( NOT USE_SPhenoMSSMTriLnV_LOOPS )

    FILE( READ ${SRCFILE} fileContent )

    STRING( REPLACE "epsTree=1.0E-1_dp" "epsTree=0.0E-1_dp" fileContent ${fileContent} )

    FILE ( WRITE ${SRCFILE} ${fileContent} )

endif()
