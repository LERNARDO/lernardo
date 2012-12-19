<erp:renderLogMonth logMonth="${logMonth}" facility="${facility}" date="${date}"/>

<p style="margin-top: 10px;">
  <a href="#" onclick="jQuery('#modal').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</a>
  %{--<g:link action="createpdf" id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>--}%
</p>

<div id="modal" style="display: none;">
  <g:form action="createpdf" id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]">
    <p><g:message code="selectPageFormat"/></p>
    <g:render template="/templates/printRadioGroup"/>
    <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
  </g:form>
</div>