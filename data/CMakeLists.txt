set( files )
list( APPEND files orthogonal.txt )
list( APPEND files total_results.txt )

install( FILES ${files} DESTINATION share/fittino/data )

set( dirs )
list( APPEND dirs HEPData-ins1599846-v1-csv )

install( DIRECTORY ${dirs} DESTINATION share/fittino/data )

add_custom_target( data SOURCES ${files} ${dirs}  )
