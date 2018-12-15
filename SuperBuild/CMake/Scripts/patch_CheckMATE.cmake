# allow xsect to be zero
set( fileName tools/python/events.py )
FILE( READ ${fileName} fileContent )
set( expr "resultCollector.signal_err_sys = resultCollector.signal_normevents*xsecterr/xsect" )
STRING( REPLACE "${expr}" "${expr} if xsect != 0.0 else 0.0" fileContent ${fileContent} )
FILE ( WRITE ${fileName} ${fileContent} )

# allow scipy versions >= 1.0.0
set( fileName tools/python/cls.py )
FILE( READ ${fileName} fileContent )
set ( expr "int(scipy.__version__.split('.')[1]) <= 10" )
string( REPLACE "${expr}" "${expr} and int(scipy.__version__.split('.')[0]) == 0" fileContent ${fileContent} )
FILE ( WRITE ${fileName} ${fileContent} )

# include unvalidated 13TeV CMS analyses
set( fileName data/analysis_info/CMS_13TeV_analyses.txt )
FILE( READ ${fileName} fileContent )
string( REPLACE "#cms_" "cms_" fileContent ${fileContent} )
FILE ( WRITE ${fileName} ${fileContent} )

# include unvalidated 13TeV ATLAS analyses
set( fileName data/analysis_info/ATLAS_13TeV_analyses.txt )
FILE( READ ${fileName} fileContent )
string( REPLACE "#atlas_" "atlas_" fileContent ${fileContent} )
FILE ( WRITE ${fileName} ${fileContent} )
