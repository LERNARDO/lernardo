<%@ page import="at.uenterprise.erp.lfa.Goal" %>



%{--<div class="fieldcontain ${hasErrors(bean: goalInstance, field: 'type', 'error')} ">
  <label for="type">
    <g:message code="goal.type.label" default="Type"/>
    
  </label>
  <g:select name="type" from="${goalInstance.constraints.type.inList}" value="${goalInstance?.type}" valueMessagePrefix="goal.type" noSelection="['': '']"/>
</div>--}%

<div class="fieldcontain ${hasErrors(bean: goalInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="goal.description.label" default="Description"/>

    </label>
    <g:textField name="description" value="${goalInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: goalInstance, field: 'dateFrom', 'error')} required">
  <label for="dateFrom">
    <g:message code="goal.dateFrom.label" default="Date From"/>
    <span class="required-indicator">*</span>
  </label>
  <g:datePicker name="dateFrom" precision="day"  value="${goalInstance?.dateFrom}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: goalInstance, field: 'dateTo', 'error')} required">
  <label for="dateTo">
    <g:message code="goal.dateTo.label" default="Date To"/>
    <span class="required-indicator">*</span>
  </label>
  <g:datePicker name="dateTo" precision="day"  value="${goalInstance?.dateTo}"  />
</div>



%{--<div class="fieldcontain ${hasErrors(bean: goalInstance, field: 'situations', 'error')} ">
  <label for="situations">
    <g:message code="goal.situations.label" default="Situations"/>
    
  </label>
  <g:select name="situations" from="${at.uenterprise.erp.lfa.Situation.list()}" multiple="multiple" optionKey="id" size="5" value="${goalInstance?.situations*.id}" class="many-to-many"/>
</div>--}%

