<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>
        <tr class="prop">
            <td height="30" colspan="3" valign="top" class="name">
                <g:message code="groupActivityTemplate"/>: <g:link controller="groupActivityTemplateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
                </td>
          </tr>
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="groupActivity.profile.name"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="groupActivity.profile.realDuration"/>:
          </td>
           <td valign="top" class="name-show">
            <g:message code="groupActivity.profile.date"/>:
          </td>

          </tr>
          <tr>
          <td width="280" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td width="150" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
           <td width="300" valign="top" class="value-show"><g:formatDate date="${group.profile.date}" format="dd. MMMM yyyy, HH:mm"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="groupActivity.profile.educationalObjective"/>:
          </td>
          <td colspan="2" valign="top" class="name-show">
            <g:message code="groupActivity.profile.educationalObjectiveText"/>:
          </td>
          </tr>
          <tr>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
          <td colspan="2" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>

        </tr>

        <tr class="prop">

           </tr>

        <tr class="prop">

        </tr>

        <tr class="prop">

        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz" >
      <h5>Aktivitäten</h5>
      <div class="zusatz-show">
      <g:if test="${templates}">
        <p>
          <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}"><img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/> <span class="red">Die Errechnete Gesamtdauer übersteigt die geplante Dauer dieses Aktivitätsblocks!</span></g:if>
        </p>

        <ul>
        <g:each in="${templates}" var="template">
          <li><g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link> (${template.profile.duration} min)</li>
        </g:each>
        </ul>
      </g:if>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Einrichtungen <app:isMeOrAdmin entity="${entity}"><g:if test="${facilities.size() == 0}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></g:if></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div  class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div  class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group]"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Pädagogen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-educators"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagoge hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-educators" targetId="educators"/>
      </jq:jquery>
      <div  class="zusatz-add" id="educators" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addEducator', id: group.id]" update="educators2" before="showspinner('#educators2')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div  class="zusatz-show" id="educators2">
        <g:render template="educators" model="${educators}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Betreute <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-clients"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupActivityProfile', action:'addClientGroup', id: group.id]" update="clients2" before="showspinner('#clients2')">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="${clients}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Erziehungsberechtigte <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-parents"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-parents" targetId="parents"/>
      </jq:jquery>
      <div  class="zusatz-add" id="parents" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupActivityProfile', action:'addParent', id: group.id]" update="parents2" before="showspinner('#parents2')">
          <g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div  class="zusatz-show" id="parents2">
        <g:render template="parents" model="${parents}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Partner <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-partners"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-partners" targetId="partners"/>
      </jq:jquery>
      <div  class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupActivityProfile', action:'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div  class="zusatz-show" id="partners2">
        <g:render template="partners" model="${partners}"/>
      </div>
    </div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: group]"/>

</body>