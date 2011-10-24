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
<div class="buttons">
  <g:form id="${entity.id}" params="[date1: formatDate(date: date1, format: 'dd. MM. yyyy'), date2: formatDate(date: date2, format: 'dd. MM. yyyy')]">
    <div class="button"><g:actionSubmit class="buttonGreen" action="createpdf" value="${message(code: 'createPDF')}" /></div>
    <div class="spacer"></div>
  </g:form>
</div>
