<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${operator.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${operator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top"  class="name-show"><g:message code="operator.profile.name"/>:</td>
          <td valign="top" width="700" class="value-show"><g:link action="show" id="${operator.id}" params="[entity:operator.id]">${operator.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.email"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.zip"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'profile.zip') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.city"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.street"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.description"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'profile.description') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="operator.profile.phone"/>:</td>
          <td valign="top" class="value-show">${fieldValue(bean: operator, field: 'profile.phone') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="showTips"/>:</td>
          <td valign="top" class="value-show"><g:formatBoolean boolean="${operator.profile.showTips}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

        <erp:isOperator entity="${currentEntity}">
          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="active"/>:</td>
            <td valign="top" class="value-show"><g:formatBoolean boolean="${operator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </erp:isOperator>

        </tbody>
      </table>
    </div>

    <erp:isMeOrAdmin entity="${operator}" current="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${operator?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isMeOrAdmin>

    <div class="zusatz">
      <h5><g:message code="facilities"/> <erp:isMeOrAdmin entity="${operator}" current="${currentEntity}"><a onclick="toggle('#facilities'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></erp:isMeOrAdmin></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote  name="formRemote" url="[controller:'operatorProfile', action:'addFacility', id: operator.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, operator: operator]"/>
      </div>
    </div>

  </div>
</div>
</body>