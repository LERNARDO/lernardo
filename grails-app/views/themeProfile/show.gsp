<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="theme"/> - ${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${theme}"/> ${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()} <span style="font-size: 12px;">(<g:message code="theme"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: theme]"/>

<div class="boxGray">

    <g:render template="/templates/themeNavigation" model="[entity: theme]"/>

      <div style="margin-top: 10px; height: 30px;">
          <span class="zusatz-show" id="labels2">
              <g:render template="labels" model="[theme: theme]"/>
          </span>
          <span class="zusatz-add hidden" id="labels">
              <g:formRemote name="formRemote2" url="[controller: 'themeProfile', action: 'addLabel', id: theme.id]" update="labels2" before="showspinner('#labels2');" after="jQuery('#labels').toggleClass('hidden').toggleClass('visible');">
                  <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
              </g:formRemote>
          </span>
          <div class="clear"></div>
      </div>

    <div class="tabnav">
      <ul>
        <li><g:link controller="themeProfile" action="show" id="${theme.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="themeProfile" action="management" id="${theme.id}"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink style="border-right: none;" update="content" controller="publication" action="list" id="${theme.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${theme}"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: theme]"/></span> <erp:accessCheck types="['Betreiber']" creatorof="${theme}"><img onclick="toggle('#setcreator');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Ersteller ändern"/></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${theme.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/>:</td>
          <td class="two"><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="end"/>:</td>
          <td class="two"><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="themes.superior"/>:</td>
          <td class="two">
            <g:if test="${parenttheme}">
              <g:link controller="themeProfile" action="show" id="${parenttheme.id}">${parenttheme.profile.fullName.decodeHTML()}</g:link>
            </g:if>
            <g:else>
              <span class="italic">Keinem übergeordneten Thema zugeordnet!</span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="facility"/>:</td>
          <td class="two"><g:link class="largetooltip" data-idd="${facility.id}" controller="facilityProfile" action="show" id="${facility?.id}">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

    </div>

</div>
</body>