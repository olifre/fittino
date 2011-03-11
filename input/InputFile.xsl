<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd" encoding="utf-8"/>

<xsl:template match="InputFile">
  <html>
    <head>
      <title>Fittino Input File</title>
      <style type="text/css">
        table { border:1px outset; }
        th, td { border:1px inset; }
        th { background-color:#9acd32; }
        h1 { font-size:x-large; }
      </style>
    </head>
    <body>
      <h1>Fittino Input File</h1>
      <table>
        <tr><th>Configuration Item</th><th>Value</th></tr>
        <xsl:apply-templates/>
      </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="VerbosityLevel">
  <tr><td>VerbosityLevel</td><td><xsl:value-of select="@Level"/></td></tr>
</xsl:template>

<xsl:template match="ExecutionMode">
  <tr><td>ExecutionMode</td><td><xsl:value-of select="@Mode"/></td></tr>
</xsl:template>

<xsl:template match="Model">
  <xsl:choose>
    <xsl:when test="@ModelType = 'Rosenbrock'">
      <tr><td>ModelType</td><td><xsl:value-of select="@ModelType"/></td></tr>
      <tr><td>X</td><td><xsl:value-of select="@X"/></td></tr>
      <tr><td>Y</td><td><xsl:value-of select="@Y"/></td></tr>
    </xsl:when>
    <xsl:when test="@ModelType = 'MSUGRA'">
      <tr><td>ModelType</td><td><xsl:value-of select="@ModelType"/></td></tr>
      <tr><td>A0</td><td><xsl:value-of select="@A0"/></td></tr>
      <tr><td>M0</td><td><xsl:value-of select="@M0"/></td></tr>
      <tr><td>M12</td><td><xsl:value-of select="@M12"/></td></tr>
      <tr><td>TanBeta</td><td><xsl:value-of select="@TanBeta"/></td></tr>
    </xsl:when>
    <xsl:otherwise>
      <tr><td>ModelType</td><td><xsl:value-of select="@ModelType"/> (unknown)</td></tr>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
