<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output 
    method="xml" 
    indent="yes" 
    encoding="UTF-8" /> <!-- ISO-8859-1 -->

  <xsl:template match="node()|@*">
    <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
  </xsl:template>
  
  <xsl:template match="/pingus-level/global/width" />
  <xsl:template match="/pingus-level/global/height" />

  <xsl:template match="pingus-level">
    <pingus-level>
      <version>2</version>
      <head>
        <xsl:apply-templates select="global/*|action-list"/>
        <xsl:if test="count(global/music) = 0">
          <music>none</music>
        </xsl:if>
        <levelsize>
          <width><xsl:value-of  select="/pingus-level/global/width" /></width>
          <height><xsl:value-of select="/pingus-level/global/height" /></height>
        </levelsize>
      </head>
      <objects>
        <xsl:apply-templates select="background|exit|entrance|hotspot|worldobj|liquid|group|groundpiece|trap"/>
      </objects>
    </pingus-level>
  </xsl:template>

  <xsl:template match="/pingus-level/global/levelname">
    <xsl:choose>
      <xsl:when test="@lang='en'">
        <levelname><xsl:apply-templates select="*"/></levelname>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/pingus-level/global/description">
    <xsl:choose>
      <xsl:when test="@lang='en'">
        <description><xsl:apply-templates select="*"/></description>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="resource">
    <xsl:variable name="datafile">
      <xsl:value-of select="resource-datafile" />
    </xsl:variable>
    <xsl:variable name="ident">
      <xsl:value-of select="resource-ident" />
    </xsl:variable>
    <image>
      <xsl:call-template name="replace-alias">
        <xsl:with-param name="text" select="concat(translate($datafile, '-', '/'), '/', $ident)" />
      </xsl:call-template>
    </image>
    <modifier>
      <xsl:choose>
        <xsl:when test="string(modifier) != ''">
          <xsl:value-of select="modifier" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>ROT0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </modifier>
  </xsl:template>

  <xsl:template name="replace-alias">
    <xsl:param name="text" />
    <xsl:choose>
      <xsl:when test="document('../data/data/alias.xml')/resources/alias[@name = $text]/@link">
        <xsl:value-of select="document('../data/data/alias.xml')/resources/alias[@name = $text]/@link" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="worldobj">
    <xsl:element name="{@type}">
      <xsl:apply-templates select="*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="liquid">
    <liquid><xsl:apply-templates select="*"/></liquid>
  </xsl:template>

  <xsl:template match="action-list/*">
    <xsl:element name="{name()}">
      <xsl:value-of select="@count"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="background">
    <xsl:choose>
      <xsl:when test="string(@type) != ''">
        <xsl:element name="{concat(@type, '-background')}">
        <xsl:apply-templates select="*"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="surface-background">
        <xsl:apply-templates select="*"/>
         </xsl:element>
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="action-list">
    <actions>
      <xsl:apply-templates select="*"/>
    </actions>
  </xsl:template>

  <xsl:template match="group">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="x-pos">
    <x><xsl:apply-templates/></x>
  </xsl:template>

  <xsl:template match="y-pos">
    <y><xsl:apply-templates/></y>
  </xsl:template>

  <xsl:template match="z-pos">
    <z><xsl:apply-templates/></z>
  </xsl:template>

  <xsl:template match="groundpiece">
    <groundpiece>
      <type><xsl:value-of select="@type"/></type>
      <xsl:apply-templates select="*"/>
    </groundpiece>
	</xsl:template>

	<xsl:template match="trap">
		<xsl:element name="{type}">
			<xsl:apply-templates select="*"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="trap/type"/>

  <xsl:template match="surface|position">
    <xsl:copy>
      <xsl:apply-templates select="*"/>
    </xsl:copy>
	</xsl:template>

  <xsl:template match="exit">
    <xsl:element name="exit">
    <xsl:if test="@use-old-pos-handling != '0'">
      <xsl:message terminate="yes">
        old-pos-handling is not supported
      </xsl:message>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="string(@owner-id) != ''">
        <xsl:apply-templates select="*"/>
      </xsl:when>
      <xsl:otherwise>
        <owner-id>0</owner-id>
        <xsl:apply-templates select="*"/>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>