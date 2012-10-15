<g:if test="${units}">
  <g:each in="${units}" var="unit" status="i">
    <div class="graypanel" style="margin: 5px 0 5px 0;">
      <table>
            <tbody>

            <tr class="prop">
              <td class="one"><g:message code="name"/></td>
              <td class="two" style="padding-right: 50px;">${unit.profile.decodeHTML()} <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeUnit" update="units2" id="${projectDay.id}" params="[unit: unit.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink>%{--<g:remoteLink action="moveUp" update="units2" id="${unit.id}" params="[projectDay: projectDay.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="${message(code:'up')}" align="top"/></g:remoteLink><g:remoteLink action="moveDown" update="units2" id="${unit.id}" params="[projectDay: projectDay.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="${message(code:'down')}" align="top"/></g:remoteLink>--}%</erp:accessCheck></td>
              <td class="one"><g:message code="begin"/></td>
              <td class="two" style="padding-right: 50px;"><g:formatDate date="${unit.profile.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/></td>
              <td class="one"><g:message code="duration"/></td>
              <td class="two">${unit.profile.duration} <g:message code="minutes"/></td>
            </tr>

            </tbody>
      </table>

      <h5 style="margin-bottom: 5px;"><g:message code="groupActivityTemplates"/></h5>
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
            <li style="list-style: decimal; margin-left: 20px;"><g:link class="hover" controller="groupActivityTemplateProfile" action="show" data-idd="${activityGroup.id}" id="${activityGroup.id}" params="[entity:activityGroup.id]">${activityGroup.profile}</g:link> <span class="gray">(${activityGroup.profile.realDuration} min)</span></li>
              <ul style="margin-top: 5px;">
                  <erp:getTemplatesOfGroupActivityTemplate groupActivityTemplate="${activityGroup}">
                      <g:each in="${templates}" var="template">
                          <li style="list-style: disc; margin-left: 40px;"><g:link class="hover" controller="${template.type.supertype.name + 'Profile'}" action="show" data-idd="${template.id}" id="${template.id}">${template.profile.decodeHTML()}</g:link></li>
                      </g:each>
                  </erp:getTemplatesOfGroupActivityTemplate>
              </ul>
          </g:each>
        </ol>
      </erp:getProjectUnitActivityGroups>

      <h5 style="margin-bottom: 5px;"><g:message code="parents"/> <erp:getProjectUnitParentsCount projectUnit="${unit}"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#parents${i}');" src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}" /></erp:accessCheck></h5>
      <div id="parents${i}" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addParent', id: unit.id, params: [i: i]]" update="parents2${i}" before="showspinner('#parents2${i}')">
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
          <g:render template="parents" model="[parents: parents, project: project, unit: unit, i: i]"/>
        </erp:getProjectUnitParents>
      </div>

      <h5 style="margin-bottom: 5px;"><g:message code="partners"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#partners${i}');" src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}" /></erp:accessCheck></h5>
      <div id="partners${i}" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addPartner', id: unit.id, params: [i: i]]" update="partners2${i}" before="showspinner('#partners2${i}')">
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
          <g:render template="partners" model="[partners: partners, project: project, unit: unit, i: i]"/>
        </erp:getProjectUnitPartners>
      </div>

    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="projectUnits.choose"/></span>
</g:else>