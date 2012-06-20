<script type="text/javascript">
  $(document).ready(function() {
    $('.largetooltip').each(function() {
      $(this).qtip({
        content: {
          text: 'Loading...',
          ajax: {
            url: '${grailsApplication.config.grails.serverURL}/profile/getTooltip',
            type: 'GET',
            data: {id : $(this).attr('data-idd')}
          }
        },
        show: {
          delay: 1000
        }
      });
    });
  });
</script>

<div class="member">

  <g:link controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">
    <erp:profileImage entity="${entity}" width="50" height="50" align="left"/>
  </g:link>

  <div><g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile.fullName.decodeHTML()}</g:link></div>
  <div class="member-type"><g:message code="${entity.type.supertype.name}"/></div>

</div>