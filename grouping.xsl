<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:key name="cities" match="item" use="@city"/>
  <xsl:key name="companies" match="item" use="concat(@city, '|', @org)"/>
  <xsl:template match="/orgs">
    <html lang="ru">
      <head>
        <meta charset="UTF-8"/>
        <title>Города и компании</title>
      </head>
      <body>
        <h1>Города и компании</h1>
        <ul>
          <xsl:for-each select="item[generate-id() = generate-id(key('cities', @city)[1])]">
            <xsl:variable name="city" select="@city"/>
            <li>
              <h3><xsl:value-of select="$city"/></h3>
              <p>Всего товаров: <xsl:value-of select="count(key('cities', $city))"/></p>
              <ul>
                <xsl:for-each select="key('cities', $city)[generate-id() = generate-id(key('companies', concat(@city, '|', @org))[1])]">
                  <xsl:variable name="org" select="@org"/>
                  <li>
                    <h4><xsl:value-of select="$org"/></h4>
                    <p>Всего товаров: <xsl:value-of select="count(key('companies', concat($city, '|', $org)))"/></p>
                    <ul>
                      <xsl:for-each select="key('companies', concat($city, '|', $org))">
                        <li><xsl:value-of select="@title"/></li>
                      </xsl:for-each>
                    </ul>
                  </li>
                </xsl:for-each>
              </ul>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
