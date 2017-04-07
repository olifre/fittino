FILE( READ configure-with-chisq fileContent )
STRING( REPLACE "clsbtablesdir=\"/blah/blah/HiggsBounds-4.0.0/\"" "clsbtablesdir=\"${clsbtablesdir}/\"" fileContent ${fileContent} )
FILE ( WRITE configure-with-chisq ${fileContent} )


#FILE( READ create_store_pathname.bat fileContent )
#STRING( REPLACE "startdir=`pwd -P`" "startdir=${DATADIR}/HiggsBounds" fileContent ${fileContent} )
#FILE ( WRITE create_store_pathname.bat ${fileContent} )

#FILE( GLOB files .  "*.f90" ) 
#FOREACH( f ${files} )
#FILE( READ ${f} fileContent )
#STRING( REPLACE "stop'" "stop '" fileContent ${fileContent} )
#FILE( WRITE ${f} ${fileContent} )
#ENDFOREACH()

