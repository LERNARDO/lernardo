<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.livingConditions"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.livingConditions').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.socioeconomicData"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.socioeconomicData').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.otherInfo"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.otherInfo').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.familyProblems"/>:
          </td>
          <td valign="top" class="value">
            <ul>
              <g:each in="${group.profile.familyProblems}" var="problem">
                <li><app:getFamilyProblem problem="${problem}"/></li>
              </g:each>
            </ul>%{--').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}--}%
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.familyIncome"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.familyIncome') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupFamily.profile.amountHousehold"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.amountHousehold') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h5>Erziehungsberechtigte <app:isMeOrAdmin entity="${group}"><a href="#" id="show-parents"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-parents" targetId="parents"/>
      </jq:jquery>
      <div id="parents" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupFamilyProfile', action:'addParent', id:group.id]" update="parents2" before="hideform('#parents')">
          <g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="parents2">
        <g:render template="parents" model="[parents: parents, group: group]"/>
      </div>
    </div>

    <div>
      <h5>Betreute <app:isMeOrAdmin entity="${group}"><a href="#" id="show-clients"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div id="clients" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupFamilyProfile', action:'addClient', id:group.id]" update="clients2" before="hideform('#clients')">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clients2">
        <g:render template="clients" model="[clients: clients, group: group]"/>
      </div>
    </div>

    <div>
      <h5>Kinder <app:isMeOrAdmin entity="${group}"><a href="#" id="show-childs"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Kinder hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-childs" targetId="childs"/>
      </jq:jquery>
      <div id="childs" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupFamilyProfile', action:'addChild', id:group.id]" update="childs2" before="hideform('#childs')">
          <g:select name="child" from="${allChilds}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="childs2">
        <g:render template="childs" model="[childs: childs, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>