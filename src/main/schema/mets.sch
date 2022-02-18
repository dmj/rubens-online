<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="mets" uri="http://www.loc.gov/METS/"/>
  <sch:pattern>
    <sch:rule context="mets:file">
      <sch:assert test="ancestor::mets:mets/mets:amdSec/mets:rightsMD[@ID = tokenize(current()/ancestor-or-self::*/@ADMID[1], '\s+')]">
        Every file is linked to a rights metadata section w/ copyright and/or license information. The file '<sch:value-of select="@ID"/>' is not.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
