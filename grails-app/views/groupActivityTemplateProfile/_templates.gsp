<script type="text/javascript">
  $(document).ready(function() {
    $('.hover').each(function() {
      $(this).qtip({
        content: {
          text: 'Loading...',
          ajax: {
            url: '${grailsApplication.config.grails.serverURL}/groupActivityTemplateProfile/templateHover',
            type: 'GET',
            data: {id : $(this).attr('data-idd')}
          }
        },
        position: {
          my: 'left center',  // Position my top left...
          at: 'right center', // at the bottom right of...
          target: 'mouse' //$(this) // my target
        }
      });
    });
  });
</script>

<g:if test="${templates}">

  <p>
    <span class="bold"><g:message code="groupActivityTemplate.profile.totalDuration"/>:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}">- <span class="red"><g:message code="groupActivityTemplate.profile.durationerror"/></span></g:if>
  </p>

  <ol id="templatesOrdered">
    <g:render template="templates2" model="[templates: templates, group: group]"/>
  </ol>

</g:if>
<g:else>
  <span class="italic red"><g:message code="activityTemplates.notAssigned"/></span>
</g:else>