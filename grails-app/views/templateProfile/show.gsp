<head>
  <title><g:message code="activityTemplate"/> - ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}</title>
  <meta name="layout" content="planning"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityTemplate"/> - ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/templateNavigation" model="[entity: template]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="templateProfile" action="show" id="${template.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${template.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${template}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${template.id}"><g:message code="comments"/> (${template.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: template]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${template.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two">${template.profile.fullName.decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="duration"/></td>
          <td class="two">${template.profile.duration} <g:message code="minutes"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.socialForm"/></td>
          <td class="two"><g:message code="socialForm.${template.profile.socialForm}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/></td>
          <td class="two"><g:message code="status.${template.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.amountEducators"/></td>
          <td class="two">${template.profile.amountEducators}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${template.profile.description.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.chosenMaterials"/></td>
          <td class="two">${template.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="two">${template?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageTo"/></td>
          <td class="two">${template?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.goal"/></td>
          <td class="two">${template?.profile?.goal?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="resources" style="display:none">

          <g:formRemote name="formRemote" url="[controller:'resourceProfile', action:'addResource', id: template.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
            <table>
              <tr>
                <td><g:message code="name"/>:</td>
                <td><g:textField id="resourceName" size="30" name="name" value=""/></td>
              </tr>
              <tr>
                <td><g:message code="description"/>:</td>
                <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
              </tr>
              <tr>
                <td><g:message code="resource.profile.amount"/>:</td>
                <td><g:textField size="5" name="amount" value="1"/></td>
              </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>

        </div>
        <div class="zusatz-show" id="resources2">
          <g:render template="/requiredResources/resources" model="[template: template, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="vMethods"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="toggle('#methods');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="methods" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addMethod', id:template.id]" update="methods2" before="showspinner('#methods2');" after="toggle('#methods');">
            <g:select name="method" from="${allMethods}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="methods2">
          <g:render template="methods" model="[template: template, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="toggle('#labels');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="labels" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addLabel', id:template.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="labels2">
          <g:render template="labels" model="[template: template, entity: currentEntity]"/>
        </div>
      </div>

    </div>

  </div>
</div>

%{--<erp:accessCheck types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: template]"/>
</erp:accessCheck>--}%

</body>