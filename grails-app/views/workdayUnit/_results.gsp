<table class="default-table">
  <thead>
  <tr>
    <th><g:message code="date"/></th>
    <g:each in="${workdaycategories}" var="category">
      <th>${category.name} (h)</th>
    </g:each>
    <th><g:message code="total"/> (h)</th>
  </tr>
  </thead>
  <tbody>
    <erp:getEvaluation entity="${entity}" date1="${date1}" date2="${date2}"/>
  </tbody>
</table>

<br/>
<a href="#" onclick="jQuery('#modal').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</a>
%{--<g:link action="createpdf" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>--}% %{--<g:link controller="excel" action="report" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy'), type: 'evaluation']"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" align="top"/> XLS</g:link>--}%

<div id="modal" style="display: none;">
  <g:form action="createpdf" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]">
    <p><g:message code="selectPageFormat"/></p>
    <g:radioGroup name="pageformat" labels="['DIN A4 Hoch (210mm × 297mm)','DIN A4 Quer (297mm × 210mm)','Letter Hoch (216mm × 279mm)','Letter Quer (279mm × 216mm)']" values="[1,2,3,4]" value="1">
      <p>${it.radio} ${it.label}</p>
    </g:radioGroup>
    <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
  </g:form>
</div>