<g:if test="${routines.size() == 0}">
  <div class="italic" style="margin-top: 5px;"><g:message code="dayroutine.noRoutines"/></div>
</g:if>

<g:else>
  <g:each in="${routines}" var="routine" status="i">
    <div class="routinebox" id="routinebox${i}">
      <g:render template="routine" model="[routine: routine, i: i]"/>
    </div>
  </g:each>
</g:else>