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
<g:link action="createpdf" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link> <g:link controller="excel" action="report" id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" align="top"/> XLS</g:link>

