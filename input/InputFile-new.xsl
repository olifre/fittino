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
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="Rosenbrock">
  <tr><td colspan="2">Rosenbrock</td></tr>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="MSUGRA">
  <tr><td colspan="2">MSUGRA</td></tr>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="Parameter">
  <tr><td><xsl:value-of select="@Name"/></td><td><xsl:value-of select="@Value"/> +- <xsl:value-of select="@Error"/></td></tr>
</xsl:template>

</xsl:stylesheet>
