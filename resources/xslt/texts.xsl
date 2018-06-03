<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:import href="shared/base.xsl"/>
    
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    
    
    <xsl:template match="/">
        <h1>Texts</h1>
        <p>
            <xsl:apply-templates select=".//tei:title"/>
        </p>
    </xsl:template>
</xsl:stylesheet>