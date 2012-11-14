<head>
  <meta name="layout" content="database"/>
  <title><g:message code="user"/> - ${user.profile}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${user}"/> ${user.profile} <span style="font-size: 12px;">(<g:message code="user"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: user]"/>

<div class="boxContent">

    <g:render template="/templates/userNavigation" model="[entity: user]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="userProfile" action="show" id="${user.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${user.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${user}"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="msg" action="inbox" id="${user.id}" before="showspinner('#content');"><g:message code="privat.posts"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="appointmentProfile" action="index" id="${user.id}" before="showspinner('#content');"><g:message code="appointments"/></g:remoteLink></li>
        <li><g:link controller="timeRecording" id="${user.id}"><g:message code="privat.workday"/></g:link></li>
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

        </tbody>
      </table>

    </div>

</div>

<g:render template="/templates/ajaxCommands" model="${ajax}"/>

</body>

