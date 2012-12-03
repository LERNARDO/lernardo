<%@ page import="at.uenterprise.erp.lfa.Situation" %>



<div class="fieldcontain ${hasErrors(bean: situationInstance, field: 'actions', 'error')} ">
  <label for="actions">
    <g:message code="situation.actions.label" default="Actions"/>
    
  </label>
  <g:select name="actions" from="${at.uenterprise.erp.base.Entity.list()}" multiple="multiple" optionKey="id" size="5" value="${situationInstance?.actions*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: situationInstance, field: 'expectedResult', 'error')} ">
  <label for="expectedResult">
    <g:message code="situation.expectedResult.label" default="Expected Result"/>
    
  </label>
  <g:textField name="expectedResult" value="${situationInstance?.expectedResult}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: situationInstance, field: 'goals', 'error')} ">
  <label for="goals">
    <g:message code="situation.goals.label" default="Goals"/>
    
  </label>
  
</div>

<div class="fieldcontain ${hasErrors(bean: situationInstance, field: 'indicator', 'error')} ">
  <label for="indicator">
    <g:message code="situation.indicator.label" default="Indicator"/>
    
  </label>
  <g:textField name="indicator" value="${situationInstance?.indicator}"/>
</div>

