<span id="favbutton">
  <g:if test="${type == 'add'}">
    <g:remoteLink class="buttonGreen" controller="profile" action="addFavorite" id="${favorite}" update="favbutton">+ <g:message code="favorite"/></g:remoteLink>
  </g:if>
  <g:else>
    <g:remoteLink class="buttonGreen" controller="profile" action="removeFavorite" id="${favorite}" update="favbutton">- <g:message code="favorite"/></g:remoteLink>
  </g:else>
</span>
<script type="text/javascript">
  $("#favtooltip").effect("highlight", {}, 3000);
  var status = $('#favorites').css('display');
  if (status == 'block') {
    ${remoteFunction(controller: 'profile', action: 'updateFavorites', update: 'favorites')}
  }
</script>