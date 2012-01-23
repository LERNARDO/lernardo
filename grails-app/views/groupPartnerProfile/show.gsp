<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupPartner"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupPartner"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/defaultNavigation" model="[entity: entity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupPartnerProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
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
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupPartner.profile.service"/>:</td>
          <td class="two">${group.profile.service}</td>
        </tr>

        </tbody>
      </table>

      <div class="zusatz">
        <h5><g:message code="partners"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#partners'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="partners" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'groupPartnerProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2')">
            <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="partners2">
          <g:render template="partners" model="[partners: partners, group: group, entity: currentEntity]"/>
        </div>
      </div>

    </div>

  </div>
</div>
</body>