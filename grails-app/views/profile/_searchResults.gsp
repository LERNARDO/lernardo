<g:each in="${searchList}" var="searchInstance">
  <div class="member">

    <div class="member-pic">
      <g:link controller="profile" action="showProfile" params="[name:searchInstance.name]">
        <ub:profileImage name="${searchInstance.name}" width="50" height="50" align="left"/>
      </g:link>
    </div>

    <div class="member-info">
      <div class="member-name"><g:link controller="profile" action="showProfile" params="[name:searchInstance.name]">${searchInstance.profile.fullName}</g:link></div>
      <div class="member-uni">${searchInstance.type.name}</div>
    </div>
    
  </div>
</g:each>
<div class="clear"></div>