<g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/> <g:remoteLink update="educatorselect" action="updateeducators" id="${group.id}"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink>
<g:if test="${allEducators}">
  <g:submitButton name="button" value="${message(code:'add')}"/>
</g:if>