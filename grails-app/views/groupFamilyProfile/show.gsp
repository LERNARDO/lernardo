<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupFamily"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupFamily"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="groupFamily.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.groupFamilyProfile.familyIncome}"><g:message code="groupFamily.profile.familyIncome"/>:</g:if></td>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.groupFamilyProfile.amountHousehold}"><g:message code="groupFamily.profile.amountHousehold"/>:</g:if></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td valign="top" class="value-show"><g:if test="${grailsApplication.config.groupFamilyProfile.familyIncome}">${fieldValue(bean: group, field: 'profile.familyIncome') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
          <td valign="top" class="value-show"><g:if test="${grailsApplication.config.groupFamilyProfile.amountHousehold}">${fieldValue(bean: group, field: 'profile.amountHousehold') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
        </tr>

        <tr>
          <td valign="top" class="name-show"><g:message code="groupFamily.profile.livingConditions"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupFamily.profile.socioeconomicData"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupFamily.profile.otherInfo"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.livingConditions').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.socioeconomicData').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.otherInfo').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr>
          <td colspan="3" valign="top" class="name-show"><g:if test="${grailsApplication.config.groupFamilyProfile.familyProblems}"><g:message code="groupFamily.profile.familyProblems"/>:</g:if></td>
        </tr>

        <tr class="prop">
          <td colspan="3" valign="top" class="value-show-block">
            <g:if test="${grailsApplication.config.groupFamilyProfile.familyProblems}">
              <g:if test="${group.profile.familyProblems}">
                <ul>
                  <g:each in="${group.profile.familyProblems}" var="problem">
                    <li>${problem}</li>
                  </g:each>
                </ul>
              </g:if>
              <g:else>
                <div class="italic"><g:message code="noData"/></div>
              </g:else>
            </g:if>
          </td>
        </tr>
      </table>
    </div>

    <div class="buttons">
      <g:form id="${group.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: group.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div id="familyCount">
      <g:render template="familycount" model="[totalLinks: totalLinks]"/>
    </div>

    <div class="zusatz">
      <h5><g:message code="groupFamily.profile.parents"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#parents');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="parents" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteParents" action="remoteParents" id="${group.id}" before="showspinner('#remoteParents');"/>
        <div id="remoteParents"></div>

      </div>
      <div class="zusatz-show" id="parents2">
        <g:render template="parents" model="[parents: parents, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="groupFamily.profile.clients"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#clients');
      return false" href="#" id="show-clients"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${group.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <g:if test="${grailsApplication.config.project == 'sueninos'}">
    <div class="zusatz">
      <h5><g:message code="groupFamily.profile.childs"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#childs');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="childs" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteChildren" action="remoteChildren" id="${group.id}" before="showspinner('#remoteChildren');"/>
        <div id="remoteChildren"></div>

        %{--<g:formRemote name="formRemote3" url="[controller:'groupFamilyProfile', action:'addChild', id:group.id]" update="childs2" before="showspinner('#childs2')">
          <g:select name="child" from="${allChilds}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>--}%
      </div>
      <div class="zusatz-show" id="childs2">
        <g:render template="childs" model="[childs: childs, group: group, entity: currentEntity]"/>
      </div>
    </div>
    </g:if>

  </div>
</div>
</body>