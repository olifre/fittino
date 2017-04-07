FILE( READ src/Makefile fileContent )

FOREACH( COMPILER "ifortg" "gfortran" "g95" "lf95" "nagfor" ) 

    STRING( REPLACE "ifeq (\${F90},${COMPILER})" "ifneq (,\$(findstring ${COMPILER},\${F90}))" fileContent ${fileContent} )

ENDFOREACH()

STRING( REPLACE "ar -ruc -U" "ar -ruc" fileContent ${fileContent} )

FILE ( WRITE src/Makefile ${fileContent} )
