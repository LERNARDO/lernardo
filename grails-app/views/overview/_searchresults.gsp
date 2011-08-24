<p class="gray"><g:message code="maxResultsShown" args="[30]"/></p>
<g:each in="${searchList}" var="searchInstance">
  <div class="member">

    <div class="member-pic">
      <g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">
        <erp:profileImage entity="${searchInstance}" width="50" height="50" align="left"/>
      </g:link>
    </div>

    <div class="member-info">
      <div class="member-name"><g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">${searchInstance.profile.fullName}</g:link></div>
      <div class="member-uni"><g:message code="profiletype.${searchInstance.type.supertype.name}"/></div>
    </div>
    
  </div>
</g:each>
<div class="spacer"></div>