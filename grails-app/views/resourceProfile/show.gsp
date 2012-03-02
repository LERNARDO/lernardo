<head>
  <meta name="layout" content="database"/>
  <title><g:message code="resource"/> - ${fieldValue(bean: resourceInstance, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="resource"/> - ${fieldValue(bean: resourceInstance, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/resourceNavigation" model="[entity: resourceInstance]"/>

    <h4><g:message code="profile"/></h4>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="location"/>:</td>
        <td class="two"><g:link controller="${location.type.supertype.name +'Profile'}" action="show" id="${location.id}">${fieldValue(bean: location, field: 'profile.fullName').decodeHTML()}</g:link></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: resourceInstance, field: 'profile.fullName').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: resourceInstance, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.amount"/>:</td>
        <td class="two">${fieldValue(bean: resourceInstance, field: 'profile.amount')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.costs"/> <span class="gray">(${grailsApplication.config.currency})</span>:</td>
        <td class="two">${fieldValue(bean: resourceInstance, field: 'profile.costs')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.costsUnit"/>:</td>
        <td class="two"><g:message code="costsUnit.${resourceInstance.profile.costsUnit}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="resource.profile.classification"/>:</td>
        <td class="two"><g:message code="resourceclass.${resourceInstance.profile.classification}"/></td>
      </tr>

    </table>

    <div class="zusatz">
      <h5><g:message code="owner"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#owner'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="owner" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteOwner" action="remoteOwner" id="${resourceInstance.id}" before="showspinner('#remoteOwner');"/>
        <div id="remoteOwner"></div>

      </div>
      <div class="zusatz-show" id="owner2">
        <g:render template="owner" model="[resowner: resowner, resourceInstance: resourceInstance]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="responsible"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#responsible'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="responsible" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteResponsible" action="remoteResponsible" id="${resourceInstance.id}" before="showspinner('#remoteResponsible');"/>
        <div id="remoteResponsible"></div>

      </div>
      <div class="zusatz-show" id="responsible2">
        <g:render template="responsible" model="[resresponsible: resresponsible, resourceInstance: resourceInstance]"/>
      </div>
    </div>

  </div>
</div>
</body>
