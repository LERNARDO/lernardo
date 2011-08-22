<div id="routinedays">
  <ul>
    <li class="${day == 'monday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'monday']" before="showspinner('#dayroutine')"><g:message code="monday"/></g:remoteLink></li>
    <li class="${day == 'tuesday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'tuesday']" before="showspinner('#dayroutine')"><g:message code="tuesday"/></g:remoteLink></li>
    <li class="${day == 'wednesday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'wednesday']" before="showspinner('#dayroutine')"><g:message code="wednesday"/></g:remoteLink></li>
    <li class="${day == 'thursday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'thursday']" before="showspinner('#dayroutine')"><g:message code="thursday"/></g:remoteLink></li>
    <li class="${day == 'friday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'friday']" before="showspinner('#dayroutine')"><g:message code="friday"/></g:remoteLink></li>
    <li class="${day == 'saturday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'saturday']" before="showspinner('#dayroutine')"><g:message code="saturday"/></g:remoteLink></li>
    <li class="${day == 'sunday' ? 'active' : ''}"><g:remoteLink update="dayroutine" action="updateday" id="${entity.id}" params="[day: 'sunday']" before="showspinner('#dayroutine')"><g:message code="sunday"/></g:remoteLink></li>
  </ul>
</div>

<div class="clear"></div>

<div id="routines">
  <g:render template="routines" model="[routines: routines]"/>
</div>