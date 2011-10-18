<erp:renderLogMonth logMonth="${logMonth}" facility="${facility}" date="${date}"/>

<div class="buttons">
  <g:form id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]">
    <div class="button"><g:actionSubmit class="buttonGreen" action="createpdf" value="${message(code: 'createPDF')}" /></div>
  </g:form>
  <div class="spacer"></div>
</div>