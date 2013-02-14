<script type="text/javascript">
  $(document).ready(function() {
    $('.timepick').timepicker({
      timeText: '${message(code: "time")}',
      hourText: '${message(code: "hour")}',
      minuteText: '${message(code: "minute")}',
      timeOnlyTitle: '${message(code: "chooseTime")}',
      stepMinute: 5
    });
  });

  $('.tooltiphelp').each(function() {
      $(this).qtip({
          content: {
              text: function(api) {
                  return $(this).attr('data-tooltip');
              }
          },
          position: {
              my: 'bottom left',
              at: 'top right',
              target: 'mouse', //$(this)
              adjust: {
                  x: 5
              }
          },
          style: {
              classes: 'ui-tooltip-green'
          }
      });
  });
</script>

<g:set var="confirmed" value="true"/>

<g:if test="${workdayunits}">
  <g:if test="${!workdayunits[0].confirmed}">
    <p class="italic green"><g:message code="workdayUnit.dayNotConfirmed"/></p>
    <g:set var="confirmed" value="false"/>
    <g:if test="${currentEntity.id == entity.id}">
      <g:formRemote name="confirmForm" url="[controller: 'timeRecording', action: 'confirmDay', id: entity.id]" update="records" before="if(!confirm('${message(code:'confirm.confirmation')}')) return false">

          <span style="display: none">
            <g:datePicker name="date" value="${date}"/>
          </span>

          <g:submitButton name="button" value="${message(code: 'day.confirm')}"/> <img class="tooltiphelp" data-tooltip="${message(code: 'workdayUnit.confirmation')}" src="${g.resource(dir:'images/icons', file:'icon_help.png')}" alt="Help" style="position: relative; top: 3px;"/>

          <div class="clear" style="margin-top: 15px;"></div>
      </g:formRemote>

      %{--<p><g:message code="workdayUnit.confirmation"/></p>--}%
    </g:if>

  </g:if>
  <g:else>
    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">

      <p class="italic red"><g:message code="workdayUnit.dayConfirmed"/></p>
      <g:formRemote name="cancelForm" url="[controller: 'timeRecording', action: 'cancelDay', id: entity.id]" update="records" before="if(!confirm('${message(code:'confirm.cancellation')}')) return false">

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
      <div class="graypanel">
        <p><span class="bold"><g:message code="workdayUnit.createEntry"/></span></p>
        <g:formRemote name="addForm" url="[controller: 'timeRecording', action: 'addRecord', id: entity.id]" update="records" before="showspinner('#records')">

          <span style="display: none">
            <g:datePicker name="date" value="${date}"/>
          </span>

          <table>
            <tr>
              <td><g:message code="from"/>:</td>
              <td><g:textField name="from" class="timepick" size="4"/></td>
            </tr>
            <tr>
              <td><g:message code="to"/>:</td>
              <td><g:textField name="to" class="timepick" size="4"/></td>
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

          <div class="clear"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="clear"></div>
        </g:formRemote>
      </div>
    </g:if>
    <g:else>
      <p class="italic red"><g:message code="workdayUnit.noCategoriesYet"/></p>
    </g:else>
  </g:if>
</g:if>

<g:if test="${!datesOrdered}">
    <div class="red italic"><g:message code="endBeforeBegin"/></div>
</g:if>

<g:if test="${intersection}">
    <div class="red italic"><g:message code="entryOverlapping"/></div>
</g:if>

<p class="bold"><g:message code="workdayUnit.alreadyEntered"/> (<g:formatNumber number="${hours}" type="number"/> <g:message code="hours"/>)</p>
<g:if test="${workdayunits}">

  <g:each in="${workdayunits}" var="unit" status="i">
    <div id="unit-${i}" style="border-bottom: 1px solid #ccc; padding: 5px; margin: 5px 0 0 0; height: 20px;">
      <g:render template="singlerecord" model="[unit: unit, i: i, entity: entity, currentEntity: currentEntity]"/>
    </div>
  </g:each>

</g:if>
<g:else>
  <span class="italic red"><g:message code="workdayUnit.noEntries"/></span>
</g:else>