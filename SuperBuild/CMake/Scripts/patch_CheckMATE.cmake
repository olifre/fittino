FILE( READ tools/python/events.py fileContent )

# allow xsect to be zero
set( expr "resultCollector.signal_err_sys = resultCollector.signal_normevents*xsecterr/xsect" )
STRING( REPLACE ${expr} "${expr} if xsect != 0.0 else 0.0" fileContent ${fileContent} )

# allow scipy versions >= 1.0.0
set ( expr "int(scipy.__version__.split('.')[1]) <= 10" )
string( REPLACE ${expr} "${expr} AND int(scipy.__version__.split('.')[0]) == 0" fileContent ${fileContent} )

FILE ( WRITE tools/python/events.py ${fileContent} )
