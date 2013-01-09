<g:if test="${units}">
  <g:each in="${units}" var="unit" status="i">
    <div class="graypanel" style="margin: 5px 0 5px 0;">
      <table>
            <tbody>

            <tr class="prop">
              <td class="one"><erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeUnit" update="units2" id="${projectDay.id}" params="[unit: unit.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck> <g:message code="name"/></td>
              <td id="unitName${i}" class="two" style="padding-right: 50px;"><g:render template="showunitname" model="[unit: unit, i: i]"/></td>
              <td class="one"><g:message code="begin"/></td>
              <td id="unitDate${i}" class="two" style="padding-right: 50px;"><g:render template="showunitdate" model="[unit: unit, i: i]"/></td>
              <td class="one"><g:message code="duration"/></td>
              <td class="two">${unit.profile.duration} <g:message code="minutes"/></td>
            </tr>

            </tbody>
      </table>

        <h5 style="margin-bottom: 5px;"><g:message code="activityTemplates"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#activities${i}');" src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
        <div id="activities${i}" style="display: none; margin: 0 0 5px 0;">

            <g:message code="search"/>:<br/>
            <erp:remoteField size="40" name="remoteField${i}" update="remoteActivityTemplate${i}" action="remoteActivityTemplate" id="${unit.id}" params="[i: i, project: project.id]" before="showspinner('#remoteActivityTemplate${i}')"/><br/>

            <g:message code="labels"/>:<br/>
            <g:formRemote name="bla" url="[action: 'remoteActivityTemplateByLabel', id: unit.id, params: [i: i, project: project.id]]" update="remoteActivityTemplate${i}">
                <erp:getAllLabels>
                    <g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/>
                </erp:getAllLabels>
                <g:submitButton name="bla" value="OK"/>
            </g:formRemote>

            <div id="remoteActivityTemplate${i}"></div>

        </div>

        <div id="activities2-${i}">
            <erp:getActivityTemplates projectUnit="${unit}" i="${i}" project="${project}"/>
                %{--<g:render template="activityTemplates" model="[activityTemplates: activityTemplates, unit: unit, i: i, project: project]"/>
            </erp:getActivityTemplates>--}%
        </div>

        %{--<h5 style="margin-bottom: 5px;"><g:message code="activityTemplates"/></h5>
        <erp:getProjectUnitActivities projectUnit="${unit}">

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
                <g:each in="${activities}" var="activity">
                    <li style="list-style: decimal; margin-left: 20px;"><g:link class="hover" controller="activityTemplateProfile" action="show" data-idd="${activity.id}" id="${activity.id}" params="[entity:activity.id]">${activity.profile}</g:link> --}%%{--<span class="gray">(${activity.profile.duration} min)</span>--}%%{--</li>
                </g:each>
            </ol>
        </erp:getProjectUnitActivities>--}%

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