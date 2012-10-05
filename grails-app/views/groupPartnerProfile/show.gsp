<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupPartner"/> - ${group.profile}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${group}"/> ${group.profile} <span style="font-size: 12px;">(<g:message code="groupPartner"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: group]"/>

<div class="boxContent">

    <g:render template="/templates/defaultNavigation" model="[entity: group]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupPartnerProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="groupPartnerProfile" action="management" id="${group.id}"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink style="border-right: none;" update="content" controller="publication" action="list" id="${group.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${group}"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupPartner.profile.service"/>:</td>
          <td class="two">${group.profile.service}</td>
        </tr>

        </tbody>
      </table>

    </div>

</div>
</body>