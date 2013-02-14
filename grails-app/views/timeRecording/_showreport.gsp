<erp:timeRecordingReport entity="${entity}" date1="${date1}" date2="${date2}"/>

<br/>
<a href="#" onclick="jQuery('#modal').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</a>
%{--<g:link action="createpdf" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>--}% %{--<g:link controller="excel" action="report" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy'), type: 'evaluation']"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" align="top"/> XLS</g:link>--}%

<div id="modal" style="display: none;">
  <g:form action="pdf" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]">
    <p><g:message code="selectPageFormat"/></p>
    <g:render template="/templates/printRadioGroup"/>
    <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
  </g:form>
</div>