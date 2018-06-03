<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:import href="shared/base.xsl"/>

    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    
  
    <xsl:template match="/">
        <style>
            body {
            position: relative;
            }
            ul.nav-pills {
          
            position: relative;
            }
            .dropdown-submenu {
            position: relative;
            }
            
            .dropdown-submenu&gt;.dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
            }
            
            .dropdown-submenu:hover&gt;.dropdown-menu {
            display: block;
            }
            
            .dropdown-submenu&gt;a:after {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
            }
            
            .dropdown-submenu:hover&gt;a:after {
            border-left-color: #fff;
            }
            
            .dropdown-submenu.pull-left {
            float: none;
            }
            
            .dropdown-submenu.pull-left&gt;.dropdown-menu {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
            }
        </style>
        
        <div class="page-header">
            <h2 align="center">
                <xsl:value-of select=".//tei:titleStmt//tei:title[@type='sub']"/>
            </h2>
            <h3 align="center">
                <xsl:value-of select=".//tei:titleStmt//tei:respStmt//text()"/>
            </h3>
        </div>
        <div class="row">
            <nav class="col-sm-2" id="myScrollspy">
                <ul class="nav nav-pills nav-stacked">
                    <li>
                        <a href="#basic_info">Basic Info</a>
                    </li>
                    <li>
                        <a href="#phys_desc">Physical Description</a>
                    </li>
                    <li>
                        <a href="#history">History</a>
                    </li>
                    <li>
                        <a href="#bibliography">Bibliography</a>
                    </li>
                    <li class="dropdown-submenu">
                        <a href="#">MS Parts</a>
                        <ul class="dropdown-menu">
                            <xsl:for-each select=".//tei:msPart">
                                <xsl:variable name="x">
                                    <xsl:number level="any" count="tei:msPart"/>
                                </xsl:variable>
                                <li class="dropdown-submenu">
                                    <a href="#mspart_{$x}">MS Parts Nr. <xsl:value-of select="$x"/>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <xsl:for-each select=".//tei:msItem">
                                            <xsl:variable name="x">
                                                <xsl:number level="any" count="tei:msItem"/>
                                            </xsl:variable>
                                            <li>
                                                <a href="#msitem_{$x}">
                                                    MS Item <xsl:value-of select="$x"/>
                                                </a>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </li>
                            </xsl:for-each>
                            
                        </ul>
                    </li>
               </ul>
            </nav>
            <div class="col-sm-10">
                <div class="regest">
                    <div class="panel panel-default" id="ms_desc">
                        <div class="panel-heading">
                            <h3 class="panel-title">
                                <h2 align="center">Manuscript Description</h2>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel panel-default">
                                <div class="panel-heading" id="basic_info">
                                    <h3 class="panel-title">
                                        <h3 align="center">Basic Info</h3>
                                    </h3>
                                </div>
                                <div class="pandel-body">
                                    <table class="table table-striped">
                                    <tr>
                                        <th>
                                            Manuscript Title
                                        </th>
                                        <td>
                                            <xsl:value-of select=".//tei:body//tei:msDesc//tei:head//tei:title"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Located at</th>
                                        <td>
                                            <xsl:value-of select=".//tei:body//tei:msDesc/tei:msIdentifier//tei:*" separator=", "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Place of Origin
                                        </th>
                                        <td>
                                            <xsl:apply-templates select=".//tei:body//tei:msDesc//tei:head//tei:origPlace"/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            Date of Origin
                                        </th>
                                        <td>
                                            <xsl:apply-templates select=".//tei:body//tei:msDesc//tei:head//tei:origDate"/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Digital Facsimile</th>
                                        <td>
                                            <xsl:apply-templates select=".//tei:body//tei:msDesc//tei:head//tei:ref"/>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" id="phys_desc">
                                    <h3 class="panel-title">
                                        <h3 align="center">Physical Description</h3>
                                    </h3>
                                </div>
                                <div class="pandel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <th>
                                                Material
                                            </th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:body//tei:objectDesc//tei:material"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Extent</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:extent"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Foliation</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:foliation"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Collation</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:collation"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Condition</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:condition"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Layout Description</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:layoutDesc"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Hands</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:handDesc"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Scripts</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:scriptDesc"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Bindings</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:bindingDesc"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" id="history">
                                    <h3 class="panel-title">
                                        <h3 align="center">History</h3>
                                    </h3>
                                </div>
                                <div class="pandel-body">
                                    <table class="table table-striped">
                                        <tr>
                                            <th>Origin</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:origin"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Provenance</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:provenance"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Acquisition</th>
                                            <td>
                                                <xsl:apply-templates select=".//tei:acquisition"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="panel panel-default" id="bibliography">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        <h3 align="center">Bibliography</h3>
                                    </h3>
                                </div>
                                <div class="pandel-body">
                                    <xsl:apply-templates select=".//tei:listBibl"/>
                                </div>
                            </div>
                            <div class="panel panel-default" id="ms_content">
                                <div class="panel-heading">
                                    <h3 class="panel-title">
                                        <h3 align="center">Content</h3>
                                    </h3>
                                </div>
                                <div class="panel-body">
                                    <xsl:for-each select=".//tei:msPart">
                                        <xsl:variable name="x">
                                            <xsl:value-of select="position()"/>
                                        </xsl:variable>
                                        <div id="mspart_{$x}">
                                            <xsl:apply-templates select="."/>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                            
                        </div>
                        <div class="panel-footer">
                            <p style="text-align:center;">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$path2source"/>
                                    </xsl:attribute>
                                    see the TEI source of this document
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            <h2 align="center">
                                Body
                            </h2>
                        </h3>
                    </div>
                    <div class="panel-body">
                        <xsl:if test="//tei:div/tei:head">
                            <h3 id="clickme">
                                <abbr title="Click to display Table of Content">[Table of Content]</abbr>
                            </h3>
                            <div id="headings" class="readmore">
                                <ul>
                                    <xsl:for-each select="/tei:TEI/tei:text/tei:body//tei:div/tei:head">
                                        <li>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:text>#hd</xsl:text>
                                                    <xsl:number level="any"/>
                                                </xsl:attribute>
                                                <xsl:number level="multiple" count="tei:div" format="1.1. "/>
                                            </a>
                                            <xsl:choose>
                                                <xsl:when test=".//tei:orig">
                                                    <xsl:apply-templates select=".//tei:orig"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="."/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:if>
        
                        <div>
                            <xsl:apply-templates select="//tei:text"/>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <p style="text-align:center;">
                            <xsl:for-each select="tei:TEI/tei:text/tei:body//tei:note">
                                <div class="footnotes">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna_</xsl:text>
                                                <xsl:number level="any" format="1" count="tei:note"/>
                                            </xsl:attribute>
                                            <span style="font-size:7pt;vertical-align:super;">
                                                <xsl:number level="any" format="1" count="tei:note"/>
                                            </span>
                                        </a>
                                    </xsl:element>
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </p>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function(){
                        $( "div[class~='readmore']" ).hide();
                        });
                        $("#clickme").click(function(){
                        $( "div[class~='readmore']" ).toggle("slow");
                        });
                    </script>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:note">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>