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
        }
      });
    });
  });
</script>

<g:if test="${templates}">

  <p>
    <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}">- %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%<span class="red">Die Errechnete Gesamtdauer übersteigt die geplante Dauer dieses Aktivitätsblocks!</span></g:if>
  </p>
  
  <ol>
  <g:each in="${templates}" var="template" status="i">
    <li style="list-style: decimal; margin-left: 20px;"><g:link class="hover" controller="${template.type.supertype.name +'Profile'}" action="show" data-idd="${template.id}" id="${template.id}" params="[entity:entity.id]">${template.profile.fullName}</g:link> <span class="gray">(${template.profile.duration} min)</span> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeTemplate" update="templates2" id="${group.id}" params="[template: template.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ol>

</g:if>
<g:else>
  <span class="italic red"><g:message code="activityTemplates.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>