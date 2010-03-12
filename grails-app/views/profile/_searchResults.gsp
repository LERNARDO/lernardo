<g:each in="${searchList}" var="searchInstance">
  <div class="member">

    <div class="member-pic">
      <g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">
        <ub:profileImage name="${searchInstance.name}" width="50" height="50" align="left"/>
      </g:link>
    </div>

    <div class="member-info">
      <div class="member-name"><g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">${searchInstance.profile.fullName}</g:link></div>
      <div class="member-uni">${searchInstance.type.name}</div>
    </div>
    
  </div>
</g:each>
<div class="clear"></div>