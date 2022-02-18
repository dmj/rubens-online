<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
  <sch:pattern>
    <sch:rule context="tei:rs[@ref]">
      <sch:report test="empty(document(resolve-uri(@ref, base-uri())))">
        Dangling reference: type=<sch:value-of select="@type"/> ref=<sch:value-of select="@ref"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
</sch:schema>
