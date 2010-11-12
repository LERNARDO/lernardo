<div id="routinedays">
  <ul>
    <li class="${day == 'monday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'monday']" before="showspinner('#dayroutine')">Montag</g:remoteLink></li>
    <li class="${day == 'tuesday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'tuesday']" before="showspinner('#dayroutine')">Dienstag</g:remoteLink></li>
    <li class="${day == 'wednesday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'wednesday']" before="showspinner('#dayroutine')">Mittwoch</g:remoteLink></li>
    <li class="${day == 'thursday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'thursday']" before="showspinner('#dayroutine')">Donnerstag</g:remoteLink></li>
    <li class="${day == 'friday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'friday']" before="showspinner('#dayroutine')">Freitag</g:remoteLink></li>
    <li class="${day == 'saturday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'saturday']" before="showspinner('#dayroutine')">Samstag</g:remoteLink></li>
    <li class="${day == 'sunday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'sunday']" before="showspinner('#dayroutine')">Sonntag</g:remoteLink></li>
  </ul>
</div>

<div class="clear"></div>

<p>Neuen Vorgang erstellen <a onclick="toggle('#newroutine');
return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Neuen Vorgang erstellen"/></a></p>
<div id="newroutine" style="display:none">
  <g:formRemote name="formRemote" url="[controller:'dayroutine', action:'save', id:entity.id, params:[day: day]]" update="routines" before="showspinner('#routines')">
    <table>
      <tr>
        <td>
          Name: <g:textField name="title" size="25"/><br/>
          von <g:select name="dateFromHour" from="${0..23}"/>:<g:select name="dateFromMinute" from="${0..59}"/> Uhr bis <g:select name="dateToHour" from="${0..23}"/>:<g:select name="dateToMinute" from="${0..59}"/> Uhr</td>
        <td>
          <g:textArea name="description" rows="4" cols="50"/>
        </td>
      </tr>
    </table>
    <g:submitButton name="submitButton" value="${message(code:'save')}"/>
    <div class="clear"></div>
  </g:formRemote>
</div>

<div id="routines">
  <g:render template="routines" model="[routines: routines]"/>
</div>