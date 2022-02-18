<p:declare-step version="3.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:mets="http://www.loc.gov/METS/"
                xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <p:output port="result" sequence="true"/>

  <p:option name="basedir" as="xs:string" select="resolve-uri('../resources/', static-base-uri())"/>

  <p:variable name="registry" as="document-node(element(mets:mets))"
              select="doc(resolve-uri('../resources/mets.xml', static-base-uri()))"/>

  <p:group>
    <p:documentation>All projects files must be listet in the METS document</p:documentation>
    <p:variable name="registry-files" as="xs:string*" select="$registry//mets:file/mets:FLocat/@xlink:href ! resolve-uri(., $basedir)"/>
    <p:directory-list path="{$basedir}" exclude-filter="mets\.xml" max-depth="unbounded"/>
    <p:viewport match="c:file">
      <p:variable name="filepath" as="xs:string" select="resolve-uri(c:file/@name, base-uri(c:file))"/>
      <p:if test="not($registry-files[. = $filepath])">
        <p:error code="file-missing-in-registry">
          <p:with-input>
            <p:inline expand-text="true">The file {$filepath} is NOT listed in the METS document</p:inline>
          </p:with-input>
        </p:error>
      </p:if>
    </p:viewport>
  </p:group>

  <p:group>
    <p:documentation>The METS document must be schema-valid</p:documentation>
    <p:validate-with-xml-schema>
      <p:with-input port="source" select="$registry"/>
      <p:with-input port="schema" href="{resolve-uri('../schema/mets.xsd', static-base-uri())}"/>
    </p:validate-with-xml-schema>
  </p:group>

  <p:sink/>

</p:declare-step>
