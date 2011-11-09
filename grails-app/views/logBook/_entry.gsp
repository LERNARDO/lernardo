<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
  <g:remoteLink update="entry" class="buttonGreen" action="deleteEntry" params="[facility: facility, date: date]">Eintrag löschen</g:remoteLink>
  <div class="clear"></div>
</erp:accessCheck>

<p>
    <g:message code="entryNotice"/>
</p>

<table class="default-table">
  <tr>
    <th>Name</th>
    <g:each in="${entry?.attendees[0]?.processes}" var="process">
      <th>${process.process.name}</th>
    </g:each>
  </tr>
  <g:each in="${entry.attendees}" var="attendee">
    <tr>
      <td>${attendee.client.profile.fullName.decodeHTML()}</td>
      <g:each in="${attendee.processes}" var="process">
        <td>
          <g:checkBox name="checkbox" disabled="${entry.isChecked}" value="${process.hasParticipated}" onclick="${remoteFunction(update: 'entry', action: 'updateEntryProcess', id: process.id, params: [entry: entry.id])}"/>
        </td>
      </g:each>
    </tr>
  </g:each>
</table>

<p>
  <span class="bold"><g:message code="comment"/></span>
  <div id="comment">
    <g:render template="entryComment" model="[entry: entry]"/>
  </div>
</p>

<p>
  <span class="bold"><g:message code="confirmed"/></span><br/>
  <g:if test="${entry.isChecked}">
    <g:set var="canChange" value="false"/>
    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
      <g:set var="canChange" value="true"/>
    </erp:accessCheck>
    <g:checkBox name="checkbox" disabled="${canChange != 'true'}" value="${entry.isChecked}" onclick="${remoteFunction(update: 'entry', action: 'updateEntry', id: entry.id)}"/>
  </g:if>
  <g:else>
    <g:checkBox name="checkbox" value="${entry.isChecked}" onclick="${remoteFunction(update: 'entry', action: 'updateEntry', id: entry.id)}"/>
  </g:else>
</p>