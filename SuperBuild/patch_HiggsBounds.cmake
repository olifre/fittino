FILE( READ configure-with-chisq fileContent )
STRING( REPLACE "clsbtablesdir=\"/blah/blah/HiggsBounds-4.0.0/\"" "clsbtablesdir=\"${DATADIR}/HiggsBounds/\"" fileContent ${fileContent} )
FILE ( WRITE configure-with-chisq ${fileContent} )


FILE( READ create_store_pathname.bat fileContent )
STRING( REPLACE "startdir=`pwd -P`" "startdir=${DATADIR}/HiggsBounds" fileContent ${fileContent} )
FILE ( WRITE create_store_pathname.bat ${fileContent} )
