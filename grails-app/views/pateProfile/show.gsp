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
    <div>
      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="firstName"/></td>
          <td valign="top" class="name-show"><g:message code="lastName"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.motherTongue"/></td>
          <td valign="top" class="name-show"><g:message code="pate.profile.languages"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td valign="top" class="value-show"><g:link action="show" id="${pate.id}" params="[entity:pate.id]">${pate.profile.lastName}</g:link></td>
          <td valign="top" class="value-show">${pate.profile.motherTongue}</td>
          <td valign="top" class="value-show-block">
            <g:if test="${pate.profile.languages}">
            <ul>
              <g:each in="${pate.profile.languages}" var="language">
                <li>${language}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
          </td>
        </tr>

      </table>

      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="zip"/></td>
          <td valign="top" class="name-show"><g:message code="city"/></td>
          <td valign="top" class="name-show"><g:message code="street"/></td>
          <td valign="top" class="name-show"><g:message code="country"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td valign="top" class="value-show">${pate.profile.country}</td>
        </tr>

        %{-- AAZ (01.09.2010): disabled until this feature is implemented --}%
        %{--<tr>
          <td colspan="4" height="30" valign="top" class="name-show">
            <g:message code="pate.profile.emails"/>: <span class="value-show">${fieldValue(bean: pate, field: 'profile.emails')}</span>
          </td>
        </tr>--}%

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${pate.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: pate, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:isMeOrAdminOrOperator entity="${pate}" current="${currentEntity}">
              <td>
                <g:form controller="profile" action="changePassword" id="${pate.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:isMeOrAdminOrOperator>
          </tr>
        </table>
      </div>

      <div class="buttons">
        <g:form id="${pate.id}">
          <erp:isMeOrAdminOrOperator entity="${pate}" current="${currentEntity}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          </erp:isMeOrAdminOrOperator>
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: pate.id)}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
        </g:form>
        <div class="spacer"></div>
      </div>

      <div class="zusatz">
        <h5><g:message code="pate.profile.gcs"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#godchildren');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="godchildren" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${pate.id}" before="showspinner('#remoteClients')"/>
        <div id="remoteClients"></div>

        </div>
        <div class="zusatz-show" id="godchildren2">
          <g:render template="godchildren" model="[godchildren: godchildren, pate: pate, entity: currentEntity]"/>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
