<head>
  <meta name="layout" content="database"/>
  <title><g:message code="profile"/> - ${operator.profile}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${operator}"/> ${operator.profile} <span style="font-size: 12px;">(<g:message code="operator"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: operator]"/>

<div class="boxContent">

    <g:render template="/templates/operatorNavigation" model="[entity: operator]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="operatorProfile" action="show" id="${operator.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="operatorProfile" action="management" id="${operator.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${operator.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${operator}"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="msg" action="inbox" id="${operator.id}" before="showspinner('#content');"><g:message code="privat.posts"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="appointmentProfile" action="index" id="${operator.id}" before="showspinner('#content');"><g:message code="appointments"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="email"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="zip"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.zip') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="city"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="street"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.description') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="phone"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.phone') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

    </div>

</div>

<g:render template="/templates/ajaxCommands" model="[ajax: ajax, ajaxId: ajaxId]"/>

</body>