FILE( READ ${MAKEFILE} fileContent )

FOREACH( COMPILER "ifortg" "gfortran" "g95" "lf95" "nagfor" ) 

    STRING( REPLACE "ifeq (\${F90},${COMPILER})" "ifneq (,\$(findstring ${COMPILER},\${F90}))" fileContent ${fileContent} )

ENDFOREACH()

# STRING( REPLACE "ar -ruc -U" "ar -ruc" fileContent ${fileContent} ) needed for SPheno 4.0.X X<3, see http://stauby.de/sarah_userforum/viewtopic.php?f=4&t=213

FILE ( WRITE ${MAKEFILE} ${fileContent} )
