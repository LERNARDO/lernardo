<head>
  <meta name="layout" content="database"/>
  <title><g:message code="resource"/> - ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="resource"/> - ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/defaultNavigation" model="[entity: resource]"/>

    <h4><g:message code="profile"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="location"/>:</td>
        <td class="two"><g:link controller="${location.type.supertype.name +'Profile'}" action="show" id="${location.id}">${fieldValue(bean: location, field: 'profile.fullName').decodeHTML()}</g:link></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: resource, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.amount"/>:</td>
        <td class="two">${fieldValue(bean: resource, field: 'profile.amount')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.costs"/> <span class="gray">(${grailsApplication.config.currency})</span>:</td>
        <td class="two">${fieldValue(bean: resource, field: 'profile.costs')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.costsUnit"/>:</td>
        <td class="two"><g:message code="costsUnit.${resource.profile.costsUnit}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.classification"/>:</td>
        <td class="two"><g:message code="resourceclass.${resource.profile.classification}"/></td>
      </tr>

    </table>

    <div class="zusatz">
      <h5><g:message code="owner"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#owner'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="owner" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteOwner" action="remoteOwner" id="${resource.id}" before="showspinner('#remoteOwner');"/>
        <div id="remoteOwner"></div>

      </div>
      <div class="zusatz-show" id="owner2">
        <g:render template="owner" model="[resowner: resowner, resource: resource, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="responsible"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#responsible'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="responsible" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteResponsible" action="remoteResponsible" id="${resource.id}" before="showspinner('#remoteResponsible');"/>
        <div id="remoteResponsible"></div>

      </div>
      <div class="zusatz-show" id="responsible2">
        <g:render template="responsible" model="[resresponsible: resresponsible, resource: resource, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>
