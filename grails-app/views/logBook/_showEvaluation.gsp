<erp:renderLogMonth logMonth="${logMonth}" facility="${facility}" date="${date}"/>

<p style="margin-top: 10px;">
  <a href="#" onclick="jQuery('#modal').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</a>
  %{--<g:link action="createpdf" id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>--}%
</p>

<div id="modal" style="display: none;">
  <g:form action="createpdf" id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]">
    <p><g:message code="selectPageFormat"/></p>
    <g:radioGroup name="pageformat" labels="['DIN A4 Hoch (210mm × 297mm)','DIN A4 Quer (297mm × 210mm)','Letter Hoch (216mm × 279mm)','Letter Quer (279mm × 216mm)']" values="[1,2,3,4]" value="1">
      <p>${it.radio} ${it.label}</p>
    </g:radioGroup>
    <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
  </g:form>
</div>