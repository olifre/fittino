# todo: Use regex

FILE( READ ${SRCFILE} fileContent )

if( USE_SPhenoMSSMTriLnV_LOOPS )

    STRING( REPLACE "epsTree=0.0E-1_dp" "epsTree=0.1E-1_dp" fileContent ${fileContent} )

else()

    STRING( REPLACE "epsTree=0.1E-1_dp" "epsTree=0.0E-1_dp" fileContent ${fileContent} )

endif()

FILE ( WRITE ${SRCFILE} ${fileContent} )
