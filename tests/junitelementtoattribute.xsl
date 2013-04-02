<?xml version="1.0" encoding="windows-1252"?>
    <!--
    Antunit outputs xml that junitreport does not recognise.
    This will convert them, by turning elements into attributes.
    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml"/>

<!-- copy anything not specifically covered elsewhere-->
  <xsl:template match="*">
    <xsl:copy-of select="."/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="testsuite">
    <testsuite>
      <!--Copy all its current attributes -->
      <xsl:copy-of select="@*"/>
      <!-- convert its named children to attributes-->
      <xsl:for-each select="tests|failures|errors|time">
        <xsl:attribute name="{name()}">
          <xsl:value-of select="text()"/>
        </xsl:attribute>
      </xsl:for-each>
      <!-- need this or it wont go into children-->
      <xsl:apply-templates/>
    </testsuite>
  </xsl:template>

  <xsl:template match="testcase">
    <testcase>
     <!--Copy all its current attributes -->
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="time">
        <xsl:value-of select="time"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </testcase>
  </xsl:template>

<!--don't understand why I need this-->
  <xsl:template match="testsuite/properties">
    <properties>
      <xsl:apply-templates/>
    </properties>
  </xsl:template>

<!-- Delete things you dont need-->
  <xsl:template match="testcase/time"/>
  <xsl:template match="testsuite/tests"/>
  <xsl:template match="testsuite/failures"/>
  <xsl:template match="testsuite/errors"/>
  <xsl:template match="testsuite/time"/>

</xsl:stylesheet>
