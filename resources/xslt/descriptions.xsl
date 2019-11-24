<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="3.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:import href="shared/tei.xsl"/>
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="currentIx"/>
    <xsl:param name="amount"/>
    <xsl:param name="progress"/>
    <xsl:variable name="backlink">
        <xsl:value-of select="concat('https://aratea-digital.acdh.oeaw.ac.at/pages/show.html?document=', $document, '&amp;directory=', $collection-name)"/>
    </xsl:variable>
    <xsl:variable name="signatur">
        <xsl:value-of select=".//tei:institution/text()"/>, <xsl:value-of select=".//tei:repository[1]/text()"/>, <xsl:value-of select=".//tei:msIdentifier/tei:idno[1]/text()"/>
    </xsl:variable>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        <link rel="stylesheet" type="text/css" href="$app-root/resources/css/mss.css"/>
        <div class="container">
            <div class="card">
                <div class="card card-header">
                    <div class="row">
                        <div class="col-md-2">
                            <xsl:if test="$prev">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-left" title="prev"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                        <div class="col-md-8">
                            <h2 align="center">
                                <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                    <xsl:apply-templates/>
                                    <br/>
                                </xsl:for-each>
                                <a>
                                    <i class="fas fa-info" title="show more info about the document" data-toggle="modal" data-target="#exampleModalLong"/>
                                </a>
                                | 
                                <a href="{$path2source}">
                                    <i class="fas fa-download" title="show TEI source"/>
                                </a>
                                |
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat('../netvis/netvis.html?type=Manuscript&amp;id=', $document)"/>
                                    </xsl:attribute>
                                    <i class="fas fa-project-diagram" title="as Network"/>
                                </a>
                            </h2>
                            <h2 style="text-align:center;">
                                <input type="range" min="1" max="{$amount}" value="{$currentIx}" data-rangeslider="" style="width:100%;"/>
                                <a id="output" class="btn btn-main btn-outline-primary btn-sm" href="show.html?document=entry__1879-03-03.xml&amp;directory=editions" role="button">go to </a>
                            </h2>
                            
                        </div>
                        <div class="col-md-2" style="text-align:right">
                            <xsl:if test="$next">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-right" title="next"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div>
                        <xsl:apply-templates select=".//tei:msDesc"/>
                    </div>
                    <div class="card-footer">
                        <p>
                            <hr/>
                            <h3>How to quote</h3>
                            Ivana Dobcheva, '<xsl:value-of select="//tei:titleStmt/tei:title[@type='sub']/text()"/>' 
                            <xsl:choose>
                                <xsl:when test="//tei:revisionDesc//tei:change/@when">
                                    (revised: <xsl:value-of select="data(.//tei:revisionDesc//tei:change/@when)"/>),
                                </xsl:when>
                                <xsl:otherwise>
                                    (2019),
                                </xsl:otherwise>
                            </xsl:choose>
                            in <i>Aratea Digital, Descriptions</i>, URL:
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$backlink"/>
                                </xsl:attribute>
                                <xsl:value-of select="$backlink"/>
                            </a>
                        </p>
                    </div>
                </div>
                <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">
                                    <xsl:for-each select="//tei:fileDesc/tei:titleStmt/tei:title">
                                        <xsl:apply-templates/>
                                        <br/>
                                    </xsl:for-each>
                                </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">x</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <table class="table table-striped">
                                    <tbody>
                                        <xsl:if test="//tei:msIdentifier">
                                            <tr>
                                                <th>
                                                    <abbr title="//tei:msIdentifie">Signatur</abbr>
                                                </th>
                                                <td>
                                                    <xsl:for-each select="//tei:msIdentifier/child::*">
                                                        <abbr>
                                                            <xsl:attribute name="title">
                                                                <xsl:value-of select="name()"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="."/>
                                                        </abbr>
                                                        <br/>
                                                    </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <tr>
                                            <th>
                                                <abbr title="//tei:availability//tei:p[1]">License</abbr>
                                            </th>
                                            <xsl:choose>
                                                <xsl:when test="//tei:licence[@target]">
                                                    <td align="center">
                                                        <a class="navlink" target="_blank">
                                                            <xsl:attribute name="href">
                                                                <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                        </a>
                                                    </td>
                                                </xsl:when>
                                                <xsl:when test="//tei:licence">
                                                    <td>
                                                        <xsl:apply-templates select="//tei:licence"/>
                                                    </td>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <td>no license provided</td>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </tr>                            
                                    </tbody>
                                </table>
                                
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='footnote text']">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>