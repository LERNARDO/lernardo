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
        <td><g:formatBoolean boolean="${process.hasParticipated}" true="Teilgenommen" false="Nicht teilgenommen"/> <g:remoteLink update="entry" action="updateEntryProcess" id="${process.id}" params="[entry: entry.id]"><g:if test="${process.hasParticipated}"><img src="${resource(dir: 'images/icons', file: 'bullet_green.png')}" alt="${message(code: 'edit')}" align="top"/></g:if><g:else><img src="${resource(dir: 'images/icons', file: 'bullet_red.png')}" alt="${message(code: 'edit')}" align="top"/></g:else></g:remoteLink></td>
      </g:each>
    </tr>
  </g:each>
</table>

<p><span class="bold"><g:message code="comment"/></span>
<div id="comment">
  <g:render template="entryComment" model="[entry: entry]"/>
</div></p>

<p><span class="bold"><g:message code="confirmed"/></span><br/>
<g:formatBoolean boolean="${entry.isChecked}" true="Ja" false="Nein"/> <g:remoteLink update="entry" action="updateEntry" id="${entry.id}"><g:if test="${entry.isChecked}"><img src="${resource(dir: 'images/icons', file: 'bullet_green.png')}" alt="${message(code: 'edit')}" align="top"/></g:if><g:else><img src="${resource(dir: 'images/icons', file: 'bullet_red.png')}" alt="${message(code: 'edit')}" align="top"/></g:else></g:remoteLink></p>