FILE( READ tools/python/events.py fileContent )
set( expr "resultCollector.signal_err_sys = resultCollector.signal_normevents*xsecterr/xsect" )
STRING( REPLACE ${expr} "${expr} if xsect != 0.0 else 0.0" fileContent ${fileContent} )
FILE ( WRITE tools/python/events.py ${fileContent} )
