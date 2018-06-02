<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foo="http://whatever" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/><!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
   
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
                                    <xsl:value-of select="position()"/>
                                </xsl:variable>
                                <li class="dropdown-submenu">
                                    <a href="#mspart_{$x}">MS Parts Nr. <xsl:value-of select="$x"/>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <xsl:for-each select=".//tei:msItem">
                                            <xsl:variable name="x">
                                                <xsl:value-of select="position()"/>
                                            </xsl:variable>
                                            <li>
                                                <a href="#msitem_{$x}">MS Item <xsl:value-of select="$x"/>
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
    </xsl:template><!--
    #####################
    ###  Formatierung ###
    #####################
-->
    
    <xsl:template match="tei:term">
        <span/>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='ul'">
                <u>
                    <xsl:apply-templates/>
                </u>
            </xsl:when>
            <xsl:when test="@rend='italic'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:when test="@rend='sup'">
                <sup>
                    <xsl:apply-templates/>
                </sup>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:attribute name="style">
                        <xsl:value-of select="@rend"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template><!--    footnotes -->
    <xsl:template match=".//msItem/tei:note">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:note">
        <xsl:element name="a">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <span style="font-size:7pt;vertical-align:super;">
                <xsl:number level="any" format="1" count="tei:note"/>
            </span>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:div">
        <xsl:choose>
            <xsl:when test="@type='regest'">
                <div>
                    <xsl:attribute name="class">
                        <text>regest</text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when><!-- transcript -->
            <xsl:when test="@type='transcript'">
                <div>
                    <xsl:attribute name="class">
                        <text>transcript</text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when><!-- Anlagen/Beilagen  -->
            <xsl:when test="@xml:id">
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template><!-- Verweise auf andere Dokumente   -->
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="@target[ends-with(.,'.xml')]">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                       show.html?ref=<xsl:value-of select="tokenize(./@target, '/')[4]"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template><!-- resp -->
    <xsl:template match="tei:respStmt/tei:resp">
        <xsl:apply-templates/> 
    </xsl:template>
    <xsl:template match="tei:respStmt/tei:name">
        <xsl:for-each select=".">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:for-each>
    </xsl:template><!-- reference strings   -->
    <xsl:template match="tei:title[@ref]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listtitle.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    <xsl:template match="tei:origPlace[@ref]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:author[@ref]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:rs[@ref or @key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">
                    <xsl:value-of select="concat('list', data(@type), '.xml')"/>
                </xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="substring-after(data(@ref), '#')"/>
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    <xsl:template match="tei:persName[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listperson.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    <xsl:template match="tei:placeName[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template>
    <xsl:template match="tei:region[@key] | tei:country[@key]">
        <strong>
            <xsl:element name="a">
                <xsl:attribute name="class">reference</xsl:attribute>
                <xsl:attribute name="data-type">listplace.xml</xsl:attribute>
                <xsl:attribute name="data-key">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </strong>
    </xsl:template><!-- additions -->
    <xsl:template match="tei:add">
        <xsl:element name="span">
            <xsl:attribute name="style">
                <xsl:text>color:blue;</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:choose>
                    <xsl:when test="@place='margin'">
                        <xsl:text>zeitgenössische Ergänzung am Rand</xsl:text>(<xsl:value-of select="./@place"/>).
                    </xsl:when>
                    <xsl:when test="@place='above'">
                        <xsl:text>zeitgenössische Ergänzung oberhalb</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='below'">
                        <xsl:text>zeitgenössische Ergänzung unterhalb</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='inline'">
                        <xsl:text>zeitgenössische Ergänzung in der gleichen Zeile</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='top'">
                        <xsl:text>zeitgenössische Ergänzung am oberen Blattrand</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='bottom'">
                        <xsl:text>zeitgenössische Ergänzung am unteren Blattrand</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>zeitgenössische Ergänzung am unteren Blattrand</xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:text/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Bücher -->
    <xsl:template match="tei:bibl">
        <xsl:element name="strong">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Seitenzahlen -->
    <xsl:template match="tei:pb">
        <xsl:element name="div">
            <xsl:attribute name="style">
                <xsl:text>text-align:right;</xsl:text>
            </xsl:attribute>
            <xsl:text>[Bl.</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </xsl:element>
        <xsl:element name="hr"/>
    </xsl:template><!-- Tabellen -->
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Überschriften -->
    <xsl:template match="tei:head">
        <xsl:if test="@xml:id[starts-with(.,'org') or starts-with(.,'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hd</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <h3>
            <div>
                <xsl:apply-templates/>
            </div>
        </h3>
    </xsl:template><!--  Quotes / Zitate -->
    <xsl:template match="tei:q">
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Zeilenumbürche   -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template><!-- Absätze    -->
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Durchstreichungen -->
    <xsl:template match="tei:del">
        <xsl:element name="strike">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:origDate[@notBefore and @notAfter]">
        <xsl:variable name="dates">
            <xsl:value-of select="./@*" separator="-"/>
        </xsl:variable>
        <abbr title="{$dates}">
            <xsl:value-of select="."/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:extent">
        <xsl:apply-templates select="./tei:measure"/>
        <xsl:apply-templates select="./tei:dimensions"/>
    </xsl:template>
    <xsl:template match="tei:measure">
        <xsl:variable name="x">
            <xsl:value-of select="./@type"/>
        </xsl:variable>
        <xsl:variable name="y">
            <xsl:value-of select="./@quantity"/>
        </xsl:variable>
        <abbr title="type: {$x}, quantity: {$y}">Measure</abbr>: <xsl:value-of select="./text()"/>
        <br/>
    </xsl:template>
    <xsl:template match="tei:dimensions">
        <xsl:variable name="x">
            <xsl:value-of select="./@type"/>
        </xsl:variable>
        <xsl:variable name="y">
            <xsl:value-of select="./@unit"/>
        </xsl:variable>
        <abbr title="type: {$x}">Dimensions:</abbr> h: <xsl:value-of select="./tei:height/text()"/>
        <xsl:value-of select="$y"/>, w: <xsl:value-of select="./tei:width/text()"/>
        <xsl:value-of select="$y"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:layoutDesc">
        <xsl:for-each select="tei:layout">
            <div>
                <xsl:value-of select="./@columns"/> Column(s) à <xsl:value-of select="./@ruledLines |./@writtenLines"/> ruled/written lines:
                <xsl:apply-templates/>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:locus">
        <xsl:variable name="folio-from-id">
            <xsl:value-of select="./@from"/>
        </xsl:variable>
        <xsl:variable name="folio-to-id">
            <xsl:value-of select="./@to"/>
        </xsl:variable>
        <xsl:variable name="url-from-facs">
            <xsl:value-of select="./ancestor::tei:TEI//tei:graphic[@n=$folio-from-id]/@url"/>
        </xsl:variable>
        <xsl:variable name="url-to-facs">
            <xsl:value-of select="./ancestor::tei:TEI//tei:graphic[@n=$folio-to-id]/@url"/>
        </xsl:variable>
        <a href="{$url-from-facs}">
            <xsl:value-of select="$folio-from-id"/>
        </a>-<a href="{$url-to-facs}">
            <xsl:value-of select="./@to"/>
        </a>
    </xsl:template>
    
    <xsl:template match="tei:handDesc">
        <xsl:for-each select="./tei:handNote">
            <div>
                <xsl:apply-templates/>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <xsl:template match="tei:scriptDesc">
        <xsl:for-each select="./tei:scriptNote">
            <div>
                Type: <xsl:value-of select="./@script"/>
                <xsl:apply-templates/>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:bindingDesc">
        <xsl:for-each select="./tei:binding">
            <div>
                Date: <xsl:value-of select="./@notBefore"/>-<xsl:value-of select="./@notAfter"/>
                <xsl:apply-templates/>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:listBibl">
        <xsl:for-each select=".//tei:bibl">
            <li>
                <xsl:apply-templates/>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:ptr">
        <xsl:variable name="x">
            <xsl:value-of select="./@target"/>
        </xsl:variable>
        <a href="{$x}" class="fas fa-link"/>
    </xsl:template>
    
    <xsl:template match="tei:msPart">
        <div class="panel panel-default">
            <div class="panel-heading">
                    <h4 align="center">
                        <xsl:value-of select="./tei:msIdentifier"/>
                        <xsl:value-of select="./tei:head"/>
                    </h4>
            </div>
            <div class="panel-body">
                <xsl:apply-templates select=".//tei:msContents"/>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:msContents">
        <xsl:for-each select=".//tei:msItem">
            <xsl:variable name="x">
                <xsl:value-of select="position()"/>
            </xsl:variable>
            <h5 id="msitem_{$x}">Manuscript Item Nr: <xsl:value-of select="$x"/>
            </h5>
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:msItem">
        <table class="table table-condensed table-bordered">
            <thead>
                <tr>
                    <th width="20%">Key</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>locus</th>
                    <td>
                        <xsl:apply-templates select="./tei:locus"/>
                    </td>
                </tr>
                <xsl:if test="./tei:note">
                    <tr>
                        <th>notes</th>
                        <td>
                            <xsl:apply-templates select="./tei:note"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:author">
                    <tr>
                        <th>author</th>
                        <td>
                            <xsl:apply-templates select="./tei:author"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:title">
                    <tr>
                        <th>title</th>
                        <td>
                            <xsl:apply-templates select="./tei:title"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:incipit">
                    <tr>
                        <th>incipit</th>
                        <td>
                            <xsl:apply-templates select="./tei:incipit"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:explicit">
                    <tr>
                        <th>explicit</th>
                        <td>
                            <xsl:apply-templates select="./tei:explicit"/>
                        </td>
                    </tr>
                 </xsl:if>
                <xsl:if test="./tei:finalRubric">
                    <tr>
                        <th>finalRubric</th>
                        <td>
                            <xsl:apply-templates select="./tei:finalRubric"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:bibl">
                    <tr>
                        <th>Bibliography</th>
                        <td>
                            <xsl:apply-templates select="./tei:bibl"/>
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>