<g:if test="${routines.size() == 0}">
  <span class="italic">Es sind momentan keine Vorgänge an diesem Tag eingetragen!</span>
</g:if>

<g:else>
  <g:each in="${routines}" var="routine" status="i">
    <div class="routinebox" id="routinebox${i}">

      <g:render template="routine" model="[routine: routine, i: i]"/>

    </div>
  </g:each>
</g:else>