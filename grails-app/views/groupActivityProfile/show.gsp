<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${group.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">

      <p><g:message code="creator"/>: <erp:createdBy entity="${group}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></p>

      <table>
        <tbody>

        <tr class="prop">
          <td height="30" colspan="3" valign="top" class="name">
            <g:if test="${template}">
              <g:message code="groupActivityTemplate"/>: <g:link controller="groupActivityTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link>
            </g:if>
            <g:else>
              <span class="italic">Vorlage wurde nicht gefunden!</span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.realDuration"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.date"/>:</td>
        </tr>

        <tr>
          <td width="280" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td width="150" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
          <td width="300" valign="top" class="value-show"><g:formatDate date="${group?.profile?.date}" format="dd. MMMM yyyy, HH:mm"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.educationalObjective"/>:</td>
          <td colspan="2" valign="top" class="name-show"><g:message code="groupActivity.profile.educationalObjectiveText"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td colspan="2" valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

        <tr>
          <td class="name-show"><g:message code="groupActivity.profile.description"/>:</td>
        </tr>
        <tr>
          <td colspan="3" class="value-show">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop"></tr>
        <tr class="prop"></tr>
        <tr class="prop"></tr>

        </tbody>
      </table>
    </div>


    <div class="buttons">
      <erp:isCreator entity="${group}">
        <g:link class="buttonGreen" action="edit" id="${group?.id}" params="[entity: group?.id]"><g:message code="edit"/></g:link>
      </erp:isCreator>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="activities"/></h5>
      <div class="zusatz-show">
        <g:if test="${templates}">
          <p>
            <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}">- %{--<img src="${g.resource(dir: 'images/icons', file: 'icon_warning.png')}" alt="Achtung" align="top"/>--}%<span class="red">Die Errechnete Gesamtdauer übersteigt die geplante Dauer dieses Aktivitätsblocks!</span></g:if>
          </p>
          <ul>
            <g:each in="${templates}" var="template">
              <li><g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link> <span class="gray">(${template.profile.duration} min)</span></li>
            </g:each>
          </ul>
        </g:if>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facilities"/> <erp:isCreator entity="${group}"><g:if test="${facilities.size() == 0}"><a onclick="toggle('#facilities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einrichtung hinzufügen"/></a></g:if></erp:isCreator></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2');" after="toggle('#facilities');">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educators"/> <erp:isCreator entity="${group}"><a onclick="toggle('#educators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Pädagoge hinzufügen"/></a></erp:isCreator></h5>
      <div class="zusatz-add" id="educators" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addEducator', id: group.id]" update="educators2" before="showspinner('#educators2');" after="toggle('#educators');">
          <div id="educatorselect">
            <g:render template="educatorselect" model="[allEducators: allEducators, group: group]"/>
          </div>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="substitute"/> <erp:isCreator entity="${group}"><a onclick="toggle('#substitutes');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Supplierung hinzufügen"/></a></erp:isCreator></h5>
      <div class="zusatz-add" id="substitutes" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addSubstitute', id: group.id]" update="substitutes2" before="showspinner('#substitutes2');" after="toggle('#substitutes');">
          <g:select name="substitute" from="${allSubstitutes}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="substitutes2">
        <g:render template="substitutes" model="[substitutes: substitutes, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="clients"/> <erp:isCreator entity="${group}"><a onclick="toggle('#clients');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></erp:isCreator></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupActivityProfile', action:'addClientGroup', id: group.id]" update="clients2" before="showspinner('#clients2');" after="toggle('#clients');">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="parents"/> <erp:isCreator entity="${group}"><a onclick="toggle('#parents');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen"/></a></erp:isCreator></h5>
      <div class="zusatz-add" id="parents" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupActivityProfile', action:'addParent', id: group.id]" update="parents2" before="showspinner('#parents2');" after="toggle('#parents');">
          <div id="parentselect">
            <g:render template="parentselect" model="[allParents: allParents, group: group]"/>
          </div>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="parents2">
        <g:render template="parents" model="[parents: parents, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partners"/> <erp:isCreator entity="${group}"><a onclick="toggle('#partners');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen"/></a></erp:isCreator></h5>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupActivityProfile', action:'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2');" after="toggle('#partners');">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: group]"/>
</erp:accessCheck>

</body>