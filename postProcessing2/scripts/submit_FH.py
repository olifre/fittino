#!/usr/bin/env python

from ROOT import TFile
import glob
import sys
import os
from os import path, environ
from subprocess import call
from time import sleep


def main():

    if len(sys.argv)!=4:
        print "Usage: ./submit_FH.py nJobs model nEntries"
        return

    nJobs=sys.argv[1]
    model=sys.argv[2]
    nEntries=sys.argv[3]

    jobdir = environ['FITTINO_FH']+'/jobs'

    if not path.exists(jobdir):
        os.makedirs(jobdir)
        
    os.chdir(jobdir)


    for i in xrange(int(nJobs)):

        command = ['qsub']
        command.extend( ['-v', 'FITTINO_SETUP=' + environ['FITTINO_SETUP'] ] )
        command.extend( ['-P', environ['FITTINO_PROJECT'] ] )

        if 'FITTINO_MAIL' in environ:
            command.extend( ['-M', environ['FITTINO_MAIL'] ] )
            command.extend( ['-m', 'ae' ] ) 
            
        command.append( environ['FITTINO'] + '/postProcessing2/scripts/job_FH.sh' )
        command.append( model )
        command.append( nEntries )

        call(command)


if __name__=="__main__":
    main()

        
        
