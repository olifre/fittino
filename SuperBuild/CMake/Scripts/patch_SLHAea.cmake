FILE( READ ${SRCFILE} fileContent )

STRING( REPLACE "std::mem_fun_ref" "std::mem_fn" fileContent "${fileContent}" )

FILE ( WRITE ${SRCFILE} "${fileContent}" )
