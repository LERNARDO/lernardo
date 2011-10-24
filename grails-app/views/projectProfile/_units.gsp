<g:if test="${units}">
  <g:each in="${units}" var="unit" status="i">
    <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      ${unit.profile.fullName}, <g:message code="begin"/>: <g:formatDate date="${unit.profile.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/>, <g:message code="duration"/>: ${unit.profile.duration} Minuten <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeUnit" update="units2" id="${projectDay.id}" params="[unit: unit.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink><g:remoteLink action="moveUp" update="units2" id="${unit.id}" params="[projectDay: projectDay.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="${message(code:'up')}" align="top"/></g:remoteLink><g:remoteLink action="moveDown" update="units2" id="${unit.id}" params="[projectDay: projectDay.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="${message(code:'down')}" align="top"/></g:remoteLink></erp:accessCheck><br/>

      <p class="bold"><g:message code="groupActivityTemplates"/></p>
      <erp:getProjectUnitActivityGroups projectUnit="${unit}">

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

        <ol>
          <g:each in="${activityGroups}" var="activityGroup">
            <li style="list-style: decimal; margin-left: 20px;"><g:link class="hover" controller="groupActivityTemplateProfile" action="show" data-idd="${activityGroup.id}" id="${activityGroup.id}" params="[entity:activityGroup.id]">${activityGroup.profile.fullName}</g:link> <span class="gray">(${activityGroup.profile.realDuration} min)</span></li>
          </g:each>
        </ol>
      </erp:getProjectUnitActivityGroups>

      <p class="bold"><g:message code="parents"/> <erp:getProjectUnitParentsCount projectUnit="${unit}"/> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#parents${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}" /></a></erp:accessCheck></p>
      <div id="parents${i}" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addParent', id:unit.id, params:[i: i]]" update="parents2${i}" before="showspinner('#parents2${i}')">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>

      <div id="parents2${i}">
        <erp:getProjectUnitParents projectUnit="${unit}">
          <g:render template="parents" model="[parents: parents, project: project, unit: unit, i: i, entity: entity]"/>
        </erp:getProjectUnitParents>
      </div>

      <p class="bold"><g:message code="partners"/> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><a onclick="toggle('#partners${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}" /></a></erp:accessCheck></p>
      <div id="partners${i}" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addPartner', id:unit.id, params:[i: i]]" update="partners2${i}" before="showspinner('#partners2${i}')">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>

      <div id="partners2${i}">
        <erp:getProjectUnitPartners projectUnit="${unit}">
          <g:render template="partners" model="[partners: partners, project: project, unit: unit, i: i, entity: entity]"/>
        </erp:getProjectUnitPartners>
      </div>

    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="projectUnits.choose"/></span>
</g:else>