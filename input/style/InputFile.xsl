<?xml version="1.0" encoding="utf-8"?>

<!-- $Id$ -->

<!--#########################################################################-->
<!--                                                                         -->
<!-- Project     Fittino - A SUSY Parameter Fitting Package                  -->
<!--                                                                         -->
<!-- File        InputFile.xsl                                               -->
<!--                                                                         -->
<!-- Description This file contains xsl templates which specify how to       -->
<!--             transform the configuration information stored in Fittino   -->
<!--             input files (in xml format) to an html page for better      -->
<!--             readability                                                 -->
<!--                                                                         -->
<!-- Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>         -->
<!--                                                                         -->
<!-- Licence     This program is free software; you can redistribute it      -->
<!--             and/or modify it under the terms of the GNU General Public  -->
<!--             License as published by the Free Software Foundation;       -->
<!--             either version 3 of he License, or (at your option) any     -->
<!--             later version.                                              -->
<!--                                                                         -->
<!--#########################################################################-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="VerbosityLevel.xsl"/>
  <xsl:include href="Model.xsl"/>
  <xsl:include href="Tool.xsl"/>
  
  <xsl:template match="InputFile">
    <!-- This template defines the overall outline of the html document -->
    <!-- It mainly provides basic style definitions and groups the top level nodes -->
    <html>
      <head>
        <title>
          Fittino Input File
        </title>
        <!-- The basic style definitions go here -->
        <style type="text/css">
          <!-- Defines the font used in the document body -->
          body { font-size:13px; font-family:"Monospace"; }
          <!-- Cell content in tables is displayed with an offset of 50px to the left -->
          td { border-left:50px solid white; }
        </style>
      </head>
      <body>
        <!-- Grouping of the top level nodes -->
        <xsl:apply-templates select="VerbosityLevel"/>
        <xsl:apply-templates select="Model"/>
        <xsl:apply-templates select="Tool"/>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
