<script type="text/javascript">
  $(document).ready(function() {
    $('.timepicker').timepicker();
  });
</script>

<g:set var="confirmed" value="true"/>

<g:if test="${workdayunits}">
  <g:if test="${!workdayunits[0].confirmed}">
    <p class="italic green"><g:message code="workdayUnit.dayNotConfirmed"/></p>
    <g:set var="confirmed" value="false"/>
    <g:if test="${currentEntity.id == entity.id}">
      <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'confirmDays', id: entity.id]" update="workdayunits" before="if(!confirm('${message(code:'confirm.confirmation')}')) return false">

          <span style="display: none">
            <g:datePicker name="date" value="${date}"/>
          </span>

          <g:submitButton name="button" value="${message(code: 'day.confirm')}"/>

          <div class="clear"></div>
      </g:formRemote>

      <p><g:message code="workdayUnit.confirmation"/></p>
    </g:if>

  </g:if>
  <g:else>
    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">

      <p class="italic red"><g:message code="workdayUnit.dayConfirmed"/></p>
      <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'cancelDays', id: entity.id]" update="workdayunits" before="if(!confirm('${message(code:'confirm.cancellation')}')) return false">

        <span style="display: none">
          <g:datePicker name="date" value="${date}"/>
        </span>

        <g:submitButton name="button" value="${message(code: 'day.cancel')}"/>
        <div class="clear"></div>
      </g:formRemote>

    </erp:accessCheck>
  </g:else>
</g:if>
<g:else>
  <g:set var="confirmed" value="false"/>
</g:else>

<g:if test="${currentEntity.id == entity.id}">
  <g:if test="${confirmed == 'false'}">
    <g:if test="${workdaycategories}">
      <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">
        <p><span class="bold"><g:message code="workdayUnit.createEntry"/></span></p>
        <g:formRemote name="formRemote2" url="[controller:'workdayUnit', action:'addWorkdayUnit', id: entity.id]" update="workdayunits" before="showspinner('#workdayunits')">

          <span style="display: none">
            <g:datePicker name="date" value="${date}"/>
          </span>

          <table>
            <tr>
              <td><g:message code="from"/>:</td>
              <td><g:textField name="from" class="timepicker" size="4"/></td>
            </tr>
            <tr>
              <td><g:message code="to"/>:</td>
              <td><g:textField name="to" class="timepicker" size="4"/></td>
            </tr>
            <tr>
              <td><g:message code="workdayCategory"/>:</td>
              <td><g:select from="${workdaycategories}" name="category" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="description"/>:</td>
              <td><g:textArea rows="3" cols="50" name="description"/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
    </g:if>
    <g:else>
      <p class="italic red"><g:message code="workdayUnit.noCategoriesYet"/></p>
    </g:else>
  </g:if>
</g:if>

<g:if test="${!datesOrdered}">
    <div class="red italic">Die Endzeit liegt vor der Beginnzeit!</div>
</g:if>

<g:if test="${intersection}">
    <div class="red italic">Der Eintrag überschneidet sich mit einem anderen Eintrag!</div>
</g:if>

<p class="bold"><g:message code="workdayUnit.alreadyEntered"/></p>
<g:if test="${workdayunits}">

  <g:each in="${workdayunits}" var="unit" status="i">
    <div id="unit-${i}" style="border-bottom: 1px solid #ccc; padding: 5px; margin: 5px 0 0 0; height: 20px;">
      <g:render template="unit" model="[unit: unit, i: i, entity: entity, currentEntity: currentEntity]"/>
    </div>
  </g:each>

</g:if>
<g:else>
  <span class="italic red"><g:message code="workdayUnit.noEntries"/></span>
</g:else>