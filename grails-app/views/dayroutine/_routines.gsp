<g:if test="${routines.size() == 0}">
  <span class="italic"><g:message code="dayroutine.noRoutines"/></span>
</g:if>

<g:else>
  <g:each in="${routines}" var="routine" status="i">
    <div class="routinebox" id="routinebox${i}">

      <g:render template="routine" model="[routine: routine, i: i]"/>

    </div>
  </g:each>
</g:else>