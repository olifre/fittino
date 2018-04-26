#!/usr/bin/env python

import sys
import os
import xml.etree.ElementTree as ET
#import lxml.etree as ET
from subprocess import call

class Modifier:
    def __init__(self, inputfile ):
        parser = ET.XMLParser()#remove_blank_text=True)
        self.tree = ET.parse( inputfile, parser )
        self.root = self.tree.getroot()
        self.parameters = self.root.findall("./Model/ModelBase/ModelParameter")


    def setRootFile( self, name ):
        self.root.find("./Tool/SimpleSampler/OutputFile").text = name


    def removePara(self, name ):
    
        found = False
        
        for parameter in self.parameters:
            
            if parameter.find("Name").text == name:
                
                    found = True
                    self.root.find("Model/ModelBase").remove(parameter)
                    break

        if not found:
            
            raise Exception("No parameter with the given name")


    def setPara( self, name, field, value ):

        found = False
        
        for parameter in self.parameters:
            
            if parameter.find("Name").text == name:
                
                if found:
                    
                    raise Exception("Several parameters with the same name")

                found = True
                parameter.find(field).text = value
    
        if not found:
            
            raise Exception("No parameter with name " + name )


    def write( self, outfile, rootfile = None ):
        
        if not rootfile:
            
            rootfile = os.path.splitext(outfile)[0] + ".root"
                
        self.setRootFile( rootfile )

        #self.tree.write(outfile, pretty_print=True, encoding="utf-8", xml_declaration=True)
        self.tree.write(outfile, encoding="utf-8", xml_declaration=True)
            
        env ={}
        env['XMLLINT_INDENT']="    "
        tree = ET.ElementTree( self.root )
        call( [ 'xmllint', '--format', '--output', outfile, outfile ], env=env )


    def addCalculator(self, calc, index  ):

        self.root.find("./Model/ModelBase/Calculators").insert( index, calc )
	

if __name__ == "__main__":


    couplings = []
    couplings.append("lambda'_232")
    couplings.append("lambda'_233")
    couplings.append("lambda'_313")
    couplings.append("lambda'_323")
    couplings.append("lambda'_332")
    couplings.append("lambda'_333")
    couplings.append("lambda_232")

    inputfile= sys.argv[1]
    
    rd313 = Modifier( inputfile )
    rd313.setPara( "md2_33", "Value", "12.5e5" )
    rd313.setPara( "lambda'_333", "Value", "1.0" )
    rd313.setPara( "lambda'_313", "Fixed", "false" )
    rd313.write("MSSMTriLnV_RD_313.xml" )
	
    rd323 = Modifier( inputfile )
    rd323.setPara( "md2_33", "Value", "12.5e5" )
    rd323.setPara( "lambda'_333", "Value", "1.0" )
    rd323.setPara( "lambda'_323", "Fixed", "false" )
    rd323.write("MSSMTriLnV_RD_323.xml" )

    rd333 = Modifier( inputfile )
    rd333.setPara( "md2_33", "Value", "12.5e5" )
    rd333.setPara( "lambda'_333", "Fixed", "false" )
    rd333.write("MSSMTriLnV_RD_333.xml" )
    
    rkstar = Modifier( inputfile )
    
    rkstar.setPara( "mq2_33", "Value", "2e6" )
    #rkstar.setPara( "mq2_33", "Value", "12.5e5" )

    rkstar.setPara( "mq2_33", "Fixed", "true" )
    rkstar.setPara( "mq2_33", "LowerBound", "1.25e6" )
    rkstar.setPara( "mq2_33", "UpperBound", "3.26e6" )
    rkstar.setPara( "mq2_33", "Error", "1e6" )

    rkstar.setPara( "lambda'_232", "Value", "0.5" )
    #rkstar.setPara( "lambda'_232", "Value", "0.05" )

    rkstar.setPara( "lambda'_232", "Fixed", "true" )
    rkstar.setPara( "lambda'_232", "LowerBound", "-0.2" )
    rkstar.setPara( "lambda'_232", "UpperBound", "+0.2" )
    rkstar.setPara( "lambda'_232", "Error", "0.1" )

    rkstar.setPara( "lambda'_233", "Value", "0.05" )
    rkstar.setPara( "lambda'_233", "Fixed", "false" )
    rkstar.setPara( "lambda'_233", "LowerBound", "-0.1" )
    rkstar.setPara( "lambda'_233", "UpperBound", "+0.020001" )
    rkstar.setPara( "lambda'_233", "Error", "0.005" )
    
    rkstar.write("MSSMTriLnV_RKstar.xml" )
    
    rk = Modifier( inputfile )

    rk.setPara( "mq2_33", "Value", "1.6e7" )
    rk.setPara( "mq2_33", "Fixed", "true" )
    #rk.setPara( "lambda'_233", "Value", "-0.015" )
    #rk.setPara( "lambda'_233", "Value", "-0.035" )
    rk.setPara( "lambda'_233", "Value", "0" )

    rk.setPara( "lambda'_233", "Fixed", "true" )
    rk.setPara( "lambda'_232", "Value", "0." )
    rk.setPara( "lambda'_232", "Fixed", "true" )
    
    #rk.setPara( "ml2_33", "Value", "2e5" )
    rk.setPara( "ml2_33", "Value", "2e4" )
    rk.setPara( "ml2_33", "Fixed", "true" )
    rk.setPara( "ml2_33", "LowerBound", "1.25e6" )
    rk.setPara( "ml2_33", "UpperBound", "3.26e6" )
    rk.setPara( "ml2_33", "Error", "1e6" )
    
    rk.setPara( "lambda'_323", "Value", "1.0" )
    rk.setPara( "lambda'_323", "Fixed", "true" )
    rk.setPara( "lambda'_323", "LowerBound", "-3.0" )
    rk.setPara( "lambda'_323", "UpperBound", "0.1" )
    rk.setPara( "lambda'_323", "Error", "1.0" )
    
    rk.setPara( "lambda_232", "Value", "0.05" )
    rk.setPara( "lambda_232", "Fixed", "false" )
    #rk.setPara( "lambda_322", "LowerBound", "-15.0" )
    #rk.setPara( "lambda_322", "UpperBound", "+0.1" )
    rk.setPara( "lambda_232", "LowerBound", "-0.000005" )
    rk.setPara( "lambda_232", "UpperBound", "+0.0000051" )
    rk.setPara( "lambda_232", "Error", "0.000001" )
    
    rk.write("MSSMTriLnV_RK.xml" )

    rkstop2 = Modifier( inputfile )
    rkstop2.setPara( "mq2_33", "Value", "12.5e5" )
    rkstop2.setPara( "lambda'_233", "Fixed", "false" )
    rkstop2.setPara( "lambda'_233", "LowerBound", "-1.0" )
    rkstop2.setPara( "lambda'_233", "UpperBound", "+1.1" )
    rkstop2.setPara( "lambda'_233", "Error", "0.2" )
    rkstop2.write("MSSMTriLnV_RK_stop_233.xml" )
    
    gratios = Modifier( inputfile )
    gratios.setPara( "md2_33", "Fixed", "false" )
    gratios.setPara( "lambda'_333", "Value", "1" )
    gratios.write( "MSSMTriLnV_gRatios.xml" )

    dc = Modifier( inputfile )
    
    dc.setPara( "M1", "Value", "4000" )
    dc.setPara( "M2", "Value", "4000" )
    dc.setPara( "M3", "Value", "4000" )
    dc.setPara( "Mu", "Value", "4000" )
    dc.setPara( "MA", "Value", "4000" )

    dc.removePara( "md2_33" )
    dc.removePara( "mq2_33" )
    dc.removePara( "mf2_high" )
    
#    dc.removePara( "M1" )
#    dc.removePara( "M2" )
#    dc.removePara( "M3" )
#    dc.removePara( "Mu" )
#    dc.removePara( "MA" )



    dc.setPara( "ml2_33", "Name", "logm" )
    dc.setPara( "logm", "LowerBound", "3.1" )
    dc.setPara( "logm", "UpperBound", "5.2" )
    dc.setPara( "logm", "Error", "1" )
    dc.setPara( "logm", "Fixed", "false" )
    


    calc = ET.Element("FormulaCalculator")
    ET.SubElement(calc, "Prefix")
 
    quantity = ET.SubElement(calc, "Quantity")
    ET.SubElement( quantity, "Name" ).text  = "md2_33"
    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"

    quantity = ET.SubElement(calc, "Quantity")
    ET.SubElement( quantity, "Name" ).text  = "mq2_33"
    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"

    quantity = ET.SubElement(calc, "Quantity")
    ET.SubElement( quantity, "Name" ).text  = "ml2_33"
    ET.SubElement( quantity, "Value" ).text  = "TMath::Power(10, 2*[logm] )"

    quantity = ET.SubElement(calc, "Quantity")
    ET.SubElement( quantity, "Name" ).text  = "mf2_high"
    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"
                  
#    quantity = ET.SubElement(calc, "Quantity")
#    ET.SubElement( quantity, "Name" ).text  = "M1"
#    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"
#
#    quantity = ET.SubElement(calc, "Quantity")
#    ET.SubElement( quantity, "Name" ).text  = "M2"
#    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"
#
#    quantity = ET.SubElement(calc, "Quantity")
#    ET.SubElement( quantity, "Name" ).text  = "M3"
#    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"
#
#    quantity = ET.SubElement(calc, "Quantity")
#    ET.SubElement( quantity, "Name" ).text  = "MA"
#    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"
#
#    quantity = ET.SubElement(calc, "Quantity")
#    ET.SubElement( quantity, "Name" ).text  = "Mu"
#    ET.SubElement( quantity, "Value" ).text  = "TMath::Power( 10, 2*[logm] )"


    dc.addCalculator( calc, 0 )
    
    for cp in couplings:
        dc.setPara( cp, "Value", "0.1" )

    dc.write( "MSSMTriLnV_Decoupling_01.xml" )

    for cp in couplings:
        dc.setPara( cp, "Value", "1.0" )

#dc.setPara( "lambda'_333", "Value", "0.9" )

    dc.write( "MSSMTriLnV_Decoupling_10.xml" )


