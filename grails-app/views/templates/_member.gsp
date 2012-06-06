<div class="member">

  <g:link controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">
    <erp:profileImage entity="${entity}" width="50" height="50" align="left"/>
  </g:link>

  <div><g:link controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile.fullName.decodeHTML()}</g:link></div>
  <div class="member-type"><g:message code="${entity.type.supertype.name}"/></div>

</div>