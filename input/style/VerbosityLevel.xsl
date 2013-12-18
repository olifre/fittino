<?xml version="1.0" encoding="utf-8"?>

<!-- $Id$ -->

<!--#########################################################################-->
<!--                                                                         -->
<!-- Project     Fittino - A SUSY Parameter Fitting Package                  -->
<!--                                                                         -->
<!-- File        VerbosityLevel.xsl                                          -->
<!--                                                                         -->
<!-- Description This file contains the xsl template which specifies how to  -->
<!--             display the level of verbosity                              -->
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

  <xsl:template match="VerbosityLevel">
    <!-- Displays the level of verbosity -->
    <p>
      <table>
        <tr><td><b><xsl:value-of select="local-name()"/></b></td><td><xsl:value-of select="."/></td></tr>
      </table>
    </p>
  </xsl:template>

</xsl:stylesheet>
