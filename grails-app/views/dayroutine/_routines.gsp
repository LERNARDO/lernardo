<g:if test="${routines.size() == 0}">
  <span class="italic">Es sind momentan keine Vorgänge an diesem Tag eingetragen!</span>
</g:if>

<g:else>
  <g:each in="${routines}" var="routine">
    <div class="routinebox">

      <table>
        <tr>
          <td>
            ${routine.title} [b] [x]<br/>
            von <g:formatDate date="${routine.dateFrom}" format="HH:mm"/> bis <g:formatDate date="${routine.dateTo}" format="HH:mm"/>
          </td>
          <td>
            ${routine.description}
          </td>
        </tr>
      </table>
    </div>
  </g:each>
</g:else>