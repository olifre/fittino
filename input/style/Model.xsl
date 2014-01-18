<?xml version="1.0" encoding="utf-8"?>

<!-- $Id$ -->

<!--#########################################################################-->
<!--                                                                         -->
<!-- Project     Fittino - A SUSY Parameter Fitting Package                  -->
<!--                                                                         -->
<!-- File        Model.xsl                                                   -->
<!--                                                                         -->
<!-- Description This file contains the xsl templates which specify how to   -->
<!--             display the configuration information of the model of       -->
<!--             interest                                                    -->
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

  <xsl:template match="Model">
    <!-- Specify here the existing model templates -->
    <xsl:apply-templates select="PhysicsModel | RosenbrockModel"/>
  </xsl:template>
  
  <xsl:template match="PhysicsModel | RosenbrockModel">
    <!-- Prints a headline with the model's name and its various associated lists -->
    <p>
      <!-- Headline -->
      <table>
        <tr><td><b>Model</b></td><td><xsl:value-of select="Name"/></td></tr>
      </table>
    </p>
    <p>
      <!-- A model consists of the following lists -->
      <!-- TODO: Add tag for list of parameters -->
      <!-- TODO: Leading empty cells still have to be inserted manually -->
      <!-- Define a table containing the model parameter configuration information -->
      <table>
        <tr>
          <td></td>
          <td><b>ModelParameter</b></td>
          <td align="right"><b>Value</b></td>
          <td aligh="right"><b>Error</b></td>
          <td aligh="right"><b>LowerBound</b></td>
          <td aligh="right"><b>UpperBound</b></td>
          <td aligh="right"><b>Status</b></td>
        </tr>
        <xsl:apply-templates select="ModelParameter"/>
      </table>
    </p>
    <xsl:apply-templates select="Observables"/>
      <table>
        <tr><td></td><td><b>Chi2Contributions</b></td></tr>
        <xsl:apply-templates select="Chi2Contribution"/>
      </table>
    <xsl:apply-templates select="CovarianceMatrices"/>
    <xsl:apply-templates select="Calculators"/>
  </xsl:template>
  
  <!-- ModelParameters -->
  
  <xsl:template match="ModelParameter">
    <!-- Creates and fills a table row with the specified model parameter configuration information -->
    <tr>
      <td></td>
      <xsl:choose>
        <xsl:when test="Name"><xsl:apply-templates select="Name"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="Value"><xsl:apply-templates select="Value"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="Error"><xsl:apply-templates select="Error"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="LowerBound"><xsl:apply-templates select="LowerBound"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="UpperBound"><xsl:apply-templates select="UpperBound"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="Fixed"><xsl:apply-templates select="Fixed"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>
  
  <!-- Observables -->
  
  <xsl:template match="Observables">
    <p>
      <!-- Defines a table containing the observable configuration information -->
      <table>
        <tr>
          <td></td>
          <td><b>Observable</b></td>
          <td align="right"><b>MeasuredValue</b></td>
          <td align="right"><b>MeasuredError</b></td>
          <td align="right"><b>Unit</b></td>
          <td align="right"><b>Calculator</b></td>
          <td align="right"><b>Status</b></td>
        </tr>
        <xsl:apply-templates select="Observable"/>
      </table>
    </p>
  </xsl:template>
  
  <xsl:template match="Observable">
    <!-- Creates and fills a table row with the specified observable configuration information -->
    <tr>
      <td></td>
      <xsl:choose>
        <xsl:when test="Name"><xsl:apply-templates select="Name"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="MeasuredValue"><xsl:apply-templates select="MeasuredValue"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="MeasuredError1"><xsl:apply-templates select="MeasuredError1"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="Unit"><xsl:apply-templates select="Unit"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="CalculatorName"><xsl:apply-templates select="CalculatorName"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="NoFit"><xsl:apply-templates select="NoFit"/></xsl:when>
        <xsl:otherwise><td></td></xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>
  
  <!-- CovarianceMatrices -->
  
  <xsl:template match="CovarianceMatrices">
    <!-- Prints a headline and a list of the specified covariance matrices -->
    <p>
      <!-- Headline -->
      <table>
        <tr>
          <td></td><td><b><xsl:value-of select="local-name()"/></b></td>
        </tr>
      </table>
      <xsl:apply-templates select="CovarianceMatrix"/>
    </p>
  </xsl:template>
  
  <xsl:template match="CovarianceMatrix">
    <p>
      <!-- Creates a table with one row and one column for each correlated observable -->
      <table>
          <tr>
            <td></td><td></td>
            <xsl:for-each select="Row">
              <td align="right"><xsl:value-of select="ObservableName"/></td>
            </xsl:for-each>
          </tr>
        <xsl:for-each select="Row">
          <tr>
            <td></td><td><xsl:value-of select="ObservableName"/></td>
            <xsl:for-each select="Col">
              <td align="right"><xsl:value-of select="."/></td>
            </xsl:for-each>
          </tr>
        </xsl:for-each>
      </table>
    </p>
  </xsl:template>
  
  <!-- Chi2Contribution -->
  
  <xsl:template match="Chi2Contribution">
    <!-- Displays the name of the chi2 contribution -->
    <tr>
      <td></td>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Left aligned cell entries -->
  
  <xsl:template match="Name">
    <td><xsl:value-of select="."/></td>
  </xsl:template>
  
  <!-- Right aligned cell entries -->
  
  <xsl:template match="CalculatorName |
                       Error |
                       LowerBound |
                       MeasuredError1 |
                       MeasuredValue |
                       Unit |
                       UpperBound |
                       Value">
    <td align="right"><xsl:value-of select="."/></td>
  </xsl:template>
  
  <!-- Parameter status -->
  
  <xsl:template match="Fixed">
    <xsl:choose>
      <xsl:when test=".='true'">
        <td align="right">fixed</td>
      </xsl:when>
      <xsl:when test=".='false'">
        <td align="right">free</td>
      </xsl:when>
      <xsl:otherwise>
        <td align="right" style="color:#FF0000">ERROR</td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Observable status -->
  
  <xsl:template match="NoFit">
    <xsl:choose>
      <xsl:when test=".='1'">
        <td align="right">fitted</td>
      </xsl:when>
      <xsl:when test=".='0'">
        <td align="right">not fitted</td>
      </xsl:when>
      <xsl:otherwise>
        <td align="right" style="color:#FF0000">ERROR</td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Calculator chain -->
  
  <xsl:template match="Calculators">
    <!-- Prints a headline and the chain of sequenced calculators -->
    <p>
      <table>
      <!-- Headline -->
        <tr>
          <td></td><td><b>CalculatorChain</b></td>
        </tr>
        <tr>
          <td></td>
          <td>
            <!-- Creates cell which displays the calculator chain -->
            Input ->
            <xsl:for-each select="*">
              <xsl:value-of select="local-name()"/> ->
            </xsl:for-each>
            Output
          </td>
        </tr>
      </table>
    </p>
    <!-- Specify here the existing calculator templates -->
    <xsl:apply-templates select="FeynHiggsCalculator |
                                 FeynHiggsSLHACalculator |
                                 HDim6Calculator |
                                 HECModelCalculator |
                                 HiggsSignalsCalculator |
                                 HiggsSignalsSLHACalculator |
                                 LHCLimitCalculator |
                                 RegressionCalculator |
                                 SPhenoSLHACalculator |
                                 TreeCalculator"/>
  </xsl:template>
  
  <!-- Individual configuration of the calculators -->
  
  <xsl:template match="FeynHiggsCalculator |
                       FeynHiggsSLHACalculator |
                       HDim6Calculator |
                       HECModelCalculator |
                       HiggsSignalsCalculator |
                       HiggsSignalsSLHACalculator |
                       LHCLimitCalculator |
                       RegressionCalculator |
                       SPhenoSLHACalculator |
                       TreeCalculator">
    <!-- Prints a headline and a list of the individual configuration items -->
    <p>
      <!-- Headline -->
      <table>
        <tr>
          <td></td><td><b><xsl:value-of select="local-name()"/></b></td><td><xsl:value-of select="Name"/></td>
        </tr>
      </table>
      <p>
        <table>
          <xsl:for-each select="*[not(self::Name)]">
            <!-- Create a new row for every configuration item -->
            <tr>
              <td></td><td></td><td><xsl:value-of select="local-name()"/></td><td align="right"><xsl:value-of select="."/></td>
            </tr>
          </xsl:for-each>
        </table>
      </p>
    </p>
  </xsl:template>

</xsl:stylesheet>
