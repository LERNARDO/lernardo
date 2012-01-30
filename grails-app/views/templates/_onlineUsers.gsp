<erp:getOnlineUsers>
  %{--<g:formatDate date="${new Date()}" format="HH:mm:ss"/>--}%
  <g:each in="${onlineUsers}" var="entity">
    <li class="icon-online"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></li>
  </g:each>
</erp:getOnlineUsers>

<script type="text/javascript">
  setTimeout(function() {
    ${remoteFunction(update: "onlineusers", controller: "profile", action: "updateonline")}
  }, 300000); // update every 5 minutes
</script>