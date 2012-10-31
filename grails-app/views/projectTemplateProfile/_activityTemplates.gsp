<script type="text/javascript">
  $(document).ready(function() {
    $('.hover').each(function() {
      $(this).qtip({
        content: {
          text: 'Loading...',
          ajax: {
            url: '${grailsApplication.config.grails.serverURL}/projectTemplateProfile/templateHover',
            type: 'GET',
            data: {id : $(this).attr('data-idd')}
          }
        },
        position: {
          my: 'left center',  // Position my top left...
          at: 'right center', // at the bottom right of...
          target: $(this) // my target
        }
      });
    });

    ${remoteFunction(action: 'updateduration', update: 'updateduration', id: projectTemplate.id)}
  });
</script>

<g:if test="${activityTemplates}">
  <div style="margin-left: 30px">
  <ul>
    <g:each in="${activityTemplates}" var="activityTemplate">
      <li><g:link class="hover" controller="${activityTemplate.type.supertype.name + 'Profile'}" action="show" data-idd="${activityTemplate.id}" id="${activityTemplate.id}">${activityTemplate.profile.decodeHTML()}</g:link> %{--(${activityTemplate.profile.duration}min)--}% <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="removeActivityTemplate" update="activities2-${i}" id="${unit.id}" params="[activityTemplate: activityTemplate.id, i: i, projectTemplate: projectTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false; showspinner('#activities2${i}')"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
  </div>
</g:if>
<g:else>
  <span class="italic red" style="margin-left: 15px"><g:message code="activityTemplates.notAssigned"/></span>
</g:else>