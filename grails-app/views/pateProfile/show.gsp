<head>
  <meta name="layout" content="private"/>
  <title><g:message code="pate"/> - ${pate.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="pate"/> - ${pate.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>

        <tr class="prop">
          <td height="22" valign="top" class="name-show"><g:message code="pate.profile.firstName"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.lastName"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.motherTongue"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.languages"/></td>
        </tr>

        <tr class="prop">
          <td width="180" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td width="200" valign="top" class="value-show"><g:link action="show" id="${pate.id}" params="[entity:pate.id]">${pate.profile.lastName}</g:link></td>
          <td width="160" valign="top" class="value-show"><erp:getLanguages language="${pate.profile.motherTongue}"/></td>
          <td width="170" valign="top" class="value-show-block">
            <ul>
              <g:each in="${pate.profile.languages}" var="language">
                <li><erp:getLanguages language="${language}"/></li>
              </g:each>
            </ul>
          </td>
        </tr>

      </table>

      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="pate.profile.zip"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.city"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.street"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.country"/></td>
        </tr>

        <tr class="prop">
          <td width="101" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td width="290" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td width="210" align="top" class="value-show"><erp:getNationalities nationality="${pate.profile.country}"/></td>
        </tr>

        %{-- AAZ (01.09.2010): disabled until this feature is implemented --}%
        %{--<tr>
          <td colspan="4" height="30" valign="top" class="name-show">
            <g:message code="pate.profile.emails"/>: <span class="value-show">${fieldValue(bean: pate, field: 'profile.emails')}</span>
          </td>
        </tr>--}%

      </table>

      <div class="email">
        <table>

          <tr class="prop">
            <erp:isOperator entity="${currentEntity}">
              <td width="60" valign="top"><span class="bold"><g:message code="active"/></span></td>
              <td width="50" valign="top"><g:formatBoolean boolean="${pate.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </erp:isOperator>

            <td width="60" valign="top"><span class="bold"><g:message code="pate.profile.email"/>:</span></td>
            <td valign="top">${fieldValue(bean: pate, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>

          </tr>
        </table>
      </div>

      <div class="buttons">
        <erp:isMeOrAdminOrOperator entity="${pate}">
          <g:link class="buttonGreen" action="edit" id="${pate?.id}"><g:message code="edit"/></g:link>
        </erp:isMeOrAdminOrOperator>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>

      <div class="zusatz">
        <h5><g:message code="pate.profile.gcs"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#godchildren');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Patenkind hinzufügen"/></a></erp:isOperator></h5>
        <div class="zusatz-add" id="godchildren" style="display:none">

          <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${pate.id}" before="showspinner('#remoteClients')"/>
        <div id="remoteClients"></div>

          %{--<g:formRemote name="formRemote" url="[controller:'pateProfile', action:'addGodchildren', id: pate.id]" update="godchildren2" before="showspinner('#godchildren2')">
            <g:select name="child" from="${allChildren}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>--}%
        </div>
        <div class="zusatz-show" id="godchildren2">
          <g:render template="godchildren" model="[godchildren: godchildren, pate: pate, entity: currentEntity]"/>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
