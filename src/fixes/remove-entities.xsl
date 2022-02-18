<xsl:transform version="3.0" exclude-result-prefixes="#all"
               xmlns:map="http://www.w3.org/2005/xpath-functions/map"
               xmlns:tei="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:variable name="register" as="map(xs:string, xs:string)"
                select="map{
                        'corporate': '../register/register-corporate.xml',
                        'person': '../register/register-person.xml',
                        'place': '../register/register-place.xml',
                        'work': '../register/register-work.xml'
                        }"/>

  <xsl:template match="tei:sourceDesc/tei:list"/>
  <xsl:template match="tei:sourceDesc/tei:listBibl"/>
  <xsl:template match="tei:sourceDesc/tei:listOrg"/>
  <xsl:template match="tei:sourceDesc/tei:listPerson"/>
  <xsl:template match="tei:sourceDesc/tei:listPlace"/>

  <xsl:template match="tei:rs[map:contains($register, string(@type))]">
    <xsl:copy>
      <xsl:sequence select="@* except @ref"/>
      <xsl:attribute name="ref" select="concat(map:get($register, string(@type)), @ref)"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
