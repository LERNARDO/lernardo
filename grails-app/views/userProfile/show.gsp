<head>
  <meta name="layout" content="database"/>
  <title><g:message code="user"/> - ${user.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="user"/> - ${user.profile.fullName}</h1>
    %{--<div class="icons" style="text-align: right;">
      <g:link action="edit" id="${user.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>--}%
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <g:render template="/templates/userNavigation" model="[entity: entity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="userProfile" action="show" id="${user.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:remoteLink></li>
        <li><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link></li>
        <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="firstName"/>:</td>
          <td class="two">${fieldValue(bean: user, field: 'profile.firstName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="lastName"/>:</td>
          <td class="two">${fieldValue(bean: user, field: 'profile.lastName').decodeHTML()}</td>
        </tr>

        %{--<tr class="prop">
          <td class="one"><g:message code="email"/>:</td>
          <td class="two"><a href="mailto:${fieldValue(bean: user, field: 'user.email').decodeHTML()}">${fieldValue(bean: user, field: 'user.email').decodeHTML()}</a></td>
        </tr>

        <erp:isSystemAdmin entity="${currentEntity}">
          <tr class="prop">
            <td class="one"><g:message code="active"/>:</td>
            <td class="two"><span style="color: ${user.user.enabled ? '#090' : '#900'}"><g:formatBoolean boolean="${user.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></span></td>
          </tr>
        </erp:isSystemAdmin>--}%

        </tbody>
      </table>

      %{--<div class="email">
        <table width="100%">
          <tr>
            <erp:isSystemAdmin entity="${currentEntity}">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${user.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:isSystemAdmin>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: user, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${user}">
              <td>
                <g:form controller="profile" action="changePassword" id="${user.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>--}%

    </div>

  </div>
</div>
</body>
