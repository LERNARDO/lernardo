<erp:getFavorite entity="${entity}"/>
<script type="text/javascript">
  $("#favtooltip").effect("highlight", {}, 3000);
  var status = $('#favorites').css('display');
  if (status == 'block') {
    ${remoteFunction(controller: 'profile', action: 'updateFavorites', update: 'favorites')}
  }
</script>