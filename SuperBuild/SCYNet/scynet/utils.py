import os

_root_dir = os.path.dirname( __file__ )
_root_dir = os.path.abspath( _root_dir )

def getData( path ):
    return os.path.join( _root_dir, 'data', path )

