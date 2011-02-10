<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user"/> - ${user.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1 style="float: left"><g:message code="user"/> - ${user.profile.fullName}</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="edit" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <table>
      <tbody>

      <tr class="prop">
        <td class="one"><g:message code="user.profile.firstName"/>:</td>
        <td class="two">${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="user.profile.lastName"/>:</td>
        <td class="two">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="user.profile.email"/>:</td>
        <td class="two"><a href="mailto:${fieldValue(bean: user, field: 'user.email').decodeHTML()}">${fieldValue(bean: user, field: 'user.email').decodeHTML()}</a></td>
      </tr>

      <erp:isSysAdmin>
        <tr class="prop">
          <td class="one"><g:message code="active"/>:</td>
          <td class="two"><span style="color: ${user.user.enabled ? '#090' : '#900'}"><g:formatBoolean boolean="${user.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></span></td>
        </tr>
      </erp:isSysAdmin>

      </tbody>
    </table>

    <erp:isMeOrAdmin entity="${user}" current="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${user?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isMeOrAdmin>

  </div>
</div>
</body>
