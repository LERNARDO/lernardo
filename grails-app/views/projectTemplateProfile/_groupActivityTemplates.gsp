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
        }
      });
    });
  });
</script>

<g:if test="${groupActivityTemplates}">
  <div style="margin-left: 30px">
  <ul>
    <g:each in="${groupActivityTemplates}" var="groupActivityTemplate">
      <li><g:link class="hover" controller="${groupActivityTemplate.type.supertype.name +'Profile'}" action="show" data-idd="${groupActivityTemplate.id}" id="${groupActivityTemplate.id}" params="[entity:groupActivityTemplate.id]">${groupActivityTemplate.profile.fullName}</g:link> (${groupActivityTemplate.profile.realDuration}min) <erp:accessCheck entity="${entity}" types="['Betreiber','Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="removeGroupActivityTemplate" update="groups2-${i}" id="${unit.id}" params="[groupActivityTemplate: groupActivityTemplate.id, i: i, projectTemplate: projectTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false; showspinner('#groups2${i}')" after="${remoteFunction(action:'updateduration',update:'updateduration', id: projectTemplate.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
  </div>
</g:if>
<g:else>
  <span class="italic red" style="margin-left: 15px"><g:message code="groupActivityTemplates.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>