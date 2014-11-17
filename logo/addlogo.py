#!/usr/bin/env python
# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        addlogo.py                                                       #
#                                                                              #
# Description This script adds the fittino logo to an eps file.                #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

class Merger:
    def __init__( self ):

        self.args = None

    def parseargs( self ):     

        import argparse
        parser = argparse.ArgumentParser(description="Adds a logo to an image.")

        parser.add_argument("input", help="Path to the image.")
        parser.add_argument("logo",  help="Path to the logo.")
        parser.add_argument("output",  help="Path to the output image.")

        
        parser.add_argument("--scale", type=float, help="Scale the logo with this factor.", default=1.)

        xgroup = parser.add_mutually_exclusive_group()
        xgroup.add_argument("--xleft", type=float, help="Relative x coordinate of left side of logo.")
        xgroup.add_argument("--xright", type=float, help="Relative x coordinate of right side of logo.")
        xgroup.add_argument("--xcenter", type=float, help="Relative x coordinate of center of logo.")

        ygroup = parser.add_mutually_exclusive_group()
        ygroup.add_argument("--ytop", type=float, help="Relative y coordinate of top side of logo.")
        ygroup.add_argument("--ybottom", type=float, help="Relative y coordinate of bottom side of logo.")
        ygroup.add_argument("--ycenter", type=float, help="Relative y coordinate of center of logo.")

        self.args = parser.parse_args()

    def addLogo( self ):

        import os.path
        
        type1 = os.path.splitext( self.args.input )[1]
        type2 = os.path.splitext( self.args.output )[1]
        type3 = os.path.splitext( self.args.logo )[1]

        if type1 == ".eps" and type2 == ".eps" and type3 == ".eps":

            self.eps()

        else:

            print "Only .eps files are supported!"

    def eps( self ):

        logo = open (self.args.logo, "rb")
        image = open(self.args.input, "rb")
        combined = open(self.args.output, "wb")

        format = ""  
        box = ""

        for line in image:

            if "!PS-Adobe-" in line:

                format=line

            if "%%BoundingBox:" in line:    

                box = line

        width  = float( box.split()[3] ) - float( box.split()[1] )
        height = float( box.split()[4] ) - float( box.split()[2] )

        logowidth = 170 * self.args.scale
        logoheight = 90 * self.args.scale

        if self.args.xleft:

            xposition = width * self.args.xleft

        elif self.args.xright:

            xposition = width * self.args.xright - logowidth

        elif self.args.xcenter:

            xposition = width * self.args.xcenter - logowidth/2.

        else:

            xposition = 0

        if self.args.ybottom:

            yposition = height * self.args.ybottom

        elif self.args.ytop:

            yposition = height * self.args.ytop - logoheight

        elif self.args.ycenter:

            yposition = height * self.args.ycenter - logoheight/2.

        else:

            yposition = height - logoheight

        combined.write(format)
        combined.write(box)
        combined.write("/Oldshowpage /showpage load def\n")
        combined.write("/showpage {} def\n")
        combined.write("gsave\n")

        image.seek(0)

        for line in image:

            combined.write(line)

        combined.write("grestore\n")
        combined.write("1 setgray " + str(xposition) + " " + str(yposition) + " " + str(logowidth) + " " + str(logoheight) + " rectfill\n")
        combined.write( str(xposition) + " " + str(yposition) + " translate\n")
        combined.write( str(self.args.scale) + " " + str(self.args.scale) + " scale\n")

        for line in logo:

            combined.write(line)

        combined.write("Oldshowpage\n")

        combined.close()
        image.close()
        logo.close()

if __name__ == "__main__" :
    merger = Merger()
    merger.parseargs()
    merger.addLogo()
