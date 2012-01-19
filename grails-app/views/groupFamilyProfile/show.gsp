<head>
  <meta name="layout" content="database"/>
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

    <g:render template="/templates/defaultNavigation" model="[entity: entity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupFamilyProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink style="border-right: none;" update="content" controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.familyIncome"/> (${grailsApplication.config.currency}):</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.familyIncome') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.amountHousehold"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.amountHousehold') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.livingConditions"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.livingConditions').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.socioeconomicData"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.socioeconomicData').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.otherInfo"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.otherInfo').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.familyProblems"/>:</td>
          <td class="two">
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
          </td>
        </tr>

        </tbody>
      </table>

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

      <div class="zusatz">
        <h5><g:message code="children"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#childs');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="childs" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteChildren" action="remoteChildren" id="${group.id}" before="showspinner('#remoteChildren');"/>
          <div id="remoteChildren"></div>

        </div>
        <div class="zusatz-show" id="childs2">
          <g:render template="childs" model="[childs: childs, group: group, entity: currentEntity]"/>
        </div>
      </div>

    </div>

  </div>
</div>
</body>