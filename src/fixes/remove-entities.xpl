<p:declare-step version="3.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <p:documentation>Remove registers from sources files and adjust pointes accordingly</p:documentation>

  <p:option name="basedir" as="xs:string" select="resolve-uri('../main/resources/', static-base-uri())"/>
  <p:directory-list path="{$basedir}" exclude-filter="mets\.xml" max-depth="unbounded"/>
  <p:for-each>
    <p:with-input select="//c:file"/>
    <p:variable name="filepath" as="xs:string" select="resolve-uri(c:file/@name, base-uri(c:file))"/>
    <p:xslt message="{$filepath}">
      <p:with-input port="source"     href="{$filepath}"/>
      <p:with-input port="stylesheet" href="remove-entities.xsl"/>
    </p:xslt>
    <p:store href="{$filepath}"/>
  </p:for-each>

</p:declare-step>
