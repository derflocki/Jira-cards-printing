<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- output method -->
    <xsl:output method="html" omit-xml-declaration="yes" cdata-section-elements="" encoding="utf-8" media-type="text/xml" indent="yes" version="1.0"/>

    <!-- root template -->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
            <title>Task cards</title>
            <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css' />
            <link rel="stylesheet" type="text/css" href="css/9_per_page.css" />
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js" />
            <script type="text/javascript" src="/js/color.js" />
        </head>
        <body>
            <div class="card-list-wrapper">
                <xsl:for-each select="rss/channel/item">
                        <div class="card-wrapper">
                            <xsl:call-template name="card" >
                                <xsl:with-param name="data" select="." />
                            </xsl:call-template>
                        </div>
                </xsl:for-each>
            </div>
        </body>
        </html>
    </xsl:template>

    <xsl:template name="card">
        <xsl:param name="data"/>
        <xsl:variable name="project" select="$data/project/@key"> </xsl:variable>

        <table class="card">
			<colgroup>
				<col style="width:80%" />
				<col style="width:20%" />
			</colgroup>
            <tr class="card-header">
                <td>
                    <xsl:attribute name="class">colorize</xsl:attribute>
                    <xsl:attribute name="data-color-hash"><xsl:value-of select="$data/project/@key" /></xsl:attribute>
					<img>
						<xsl:attribute name="class">priority</xsl:attribute>
						<xsl:attribute name="src">http://api.qrserver.com/v1/create-qr-code/?data=<xsl:value-of select="$data/link" />&amp;format=svg&amp;size=32x32&amp;ecc=L"</xsl:attribute>
					</img>
					&#160;
                    <img src="{$data/priority/@iconUrl}" class="priority"/>
					<h1><a>
						<xsl:attribute name="href">
							<xsl:value-of select="$data/link" />
						</xsl:attribute>
						<xsl:value-of select="$data/key" />
						</a>
					</h1>
                    <xsl:if test="$data/customfields/customfield[@id='customfield_10006']/customfieldvalues[1]/customfieldvalue">
                        <span class="storypoints">
                            <xsl:value-of select="$data/customfields/customfield[@id='customfield_10006']/customfieldvalues[1]/customfieldvalue" />
                        </span>
                    </xsl:if>
                </td>
				<td>
					<xsl:attribute name="class">colorize</xsl:attribute>
					<xsl:attribute name="data-color-hash"><xsl:value-of select="$data/project/@key" /></xsl:attribute>
					<xsl:if test="$data/fixVersion">
						<div class="version">V: <xsl:value-of select="$data/fixVersion" /></div>
					 </xsl:if>
				</td>
				<!-- parent
                <td class="colorize right">
                    <xsl:choose>
                        <xsl:when test="$data/parent">
                            <xsl:attribute name="data-color-hash"><xsl:value-of select="$data/parent" /></xsl:attribute>
                            <strong><xsl:value-of select="$data/parent" /></strong>
                        </xsl:when>
                        <xsl:when test="$data/customfields/customfield[@key='com.pyxis.greenhopper.jira:gh-epic-link']/customfieldvalues[1]/customfieldvalue">
                            <xsl:attribute name="data-color-hash">
                                <xsl:value-of select="$data/customfields/customfield[@key='com.pyxis.greenhopper.jira:gh-epic-link']/customfieldvalues[1]/customfieldvalue" />
                            </xsl:attribute>
                            <strong><xsl:value-of select="$data/customfields/customfield[@key='com.pyxis.greenhopper.jira:gh-epic-link']/customfieldvalues[1]/customfieldvalue" /></strong>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="data-color-hash"><xsl:value-of select="$data/project/@key" /></xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
				-->
            </tr>
            <tr class="summary">
                <td colspan="3"><xsl:value-of select="$data/summary" /></td>
            </tr>
            <tr class="description">
                <td colspan="3">

				</td>
            </tr>
            <tr class="description">
                <td colspan="3"><xsl:value-of select="$data/description" disable-output-escaping="yes"/></td>
            </tr>
            <tr>
				<td colspan="3">
					<div class="comments">
						<xsl:value-of select="$data/comments" disable-output-escaping="yes"/>
					</div>
				</td>
            </tr>
        </table>

    </xsl:template>

</xsl:stylesheet>
