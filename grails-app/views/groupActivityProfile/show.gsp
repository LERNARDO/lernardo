<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivity.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivity.profile.educationalObjective"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivity.profile.educationalObjectiveText"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivity.profile.realDuration"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivity.profile.date"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${group.profile.date}" format="dd. MMMM yyyy, HH:mm"/></td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Aktivitäten</h1>

      <g:if test="${templates}">
        <p>
          <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}"><img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/> <span class="red">Die Errechnete Gesamtdauer übersteigt die geplante Dauer dieses Aktivitätsblocks!</span></g:if>
        </p>

        <ul>
        <g:each in="${templates}" var="template">
          <li>${template.profile.fullName} (${template.profile.duration} min)</li>
        </g:each>
        </ul>
      </g:if>
    </div>

    <div>
      <h1>Einrichtungen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addFacility', id: group.id]" update="facilities2" before="hideform('#facilities')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group]"/>
      </div>
    </div>

    <div>
      <h1>Pädagogen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-educators"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagoge hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-educators" targetId="educators"/>
      </jq:jquery>
      <div id="educators" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addEducator', id: group.id]" update="educators2" before="hideform('#educators')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="educators2">
        <g:render template="educators" model="${educators}"/>
      </div>
    </div>

    <div>
      <h1>Betreutengruppen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-clientgroups"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreutengruppe hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-clientgroups" targetId="clientgroups"/>
      </jq:jquery>
      <div id="clientgroups" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupActivityProfile', action:'addClientGroup', id: group.id]" update="clientgroups2" before="hideform('#clientgroups')">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clientgroups2">
        <g:render template="clientgroups" model="${clientgroups}"/>
      </div>
    </div>

    <div>
      <h1>Erziehungsberechtigte <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-parents"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-parents" targetId="parents"/>
      </jq:jquery>
      <div id="parents" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupActivityProfile', action:'addParent', id: group.id]" update="parents2" before="hideform('#parents')">
          <g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="parents2">
        <g:render template="parents" model="${parents}"/>
      </div>
    </div>

    <div>
      <h1>Partner <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-partners"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-partners" targetId="partners"/>
      </jq:jquery>
      <div id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupActivityProfile', action:'addPartner', id: group.id]" update="partners2" before="hideform('#partners')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="partners2">
        <g:render template="partners" model="${partners}"/>
      </div>
    </div>

  </div>
</div>
</body>