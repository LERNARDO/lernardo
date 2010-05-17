<head>
  <meta name="layout" content="private-cal"/>
  <title>Lernardo | Übersicht</title>
</head>
<body>

<div class="headerBlue">
  <div class="second">
    <h1>Glossar <a href="#" id="glossar-toggler">(ein-/ausblenden)</a></h1>
  </div>
</div>
<jq:jquery>
  <jq:toggle sourceId="glossar-toggler" targetId="glossar-toggled"/>
</jq:jquery>
<div class="boxGray" id="glossar-toggled">
  <div class="second" id="userlist-results">
    <p>Bitte eine Auswahl treffen!</p>
    <g:render template="glossary" model="[glossary: glossary]"/>
  </div>
</div>

<div class="headerBlue">
  <div class="second">
    <h1>Suche <a href="#" id="suche-toggler">(ein-/ausblenden)</a></h1>
  </div>
</div>
<jq:jquery>
  <jq:toggle sourceId="suche-toggler" targetId="suche-toggled"/>
</jq:jquery>
<div class="boxGray" id="suche-toggled">
  <div class="second">

    <div id="body-list">
      <g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
        <fieldset>
          <div class="form-content">
            <div>
              <label for="name">Bitte einen Namen eingeben:</label>
              <input id="name" type="text" name="name"/>
            </div>
            <div class="buttons" style="padding-bottom: 5px">
              <g:submitButton name="button" value="Suchen"/>
              <div class="clear"></div>
            </div>
          </div>
        </fieldset>
      </g:formRemote>

      <div class="membersearch-results" id="membersearch-results">
      </div>

    </div>
  </div>
</div>

<div class="headerBlue">
  <div class="second">
    <h1>Übersicht</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      <h1>Admin <a href="#" id="admin-toggler">(ein-/ausblenden)</a></h1>
      <jq:jquery>
        <jq:toggle sourceId="admin-toggler" targetId="admin-toggled"/>
      </jq:jquery>
      <div class="overview" id="admin-toggled">
        <div class="box">
          <div class="bold">Betreiber</div>
          <g:link controller="operatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="operatorProfile" action="list">Alle anzeigen (${allOperators})</g:link></div>
          <div><g:link controller="operatorProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">User</div>
          <g:link controller="userProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="userProfile" action="list">Alle anzeigen (${allUsers})</g:link></div>
          <div><g:link controller="userProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Verwaltung</div>
          <g:link controller="profile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="profile" action="list" params="[name:entity.name]">Alle anzeigen</g:link></div>
          %{--<div><g:link controller="userProfile" action="create">Neu anlegen</g:link></div>--}%
        </div>
      </div>
      <div class="clear"></div>

      <h1>Personen <a href="#" id="personen-toggler">(ein-/ausblenden)</a></h1>
      <jq:jquery>
        <jq:toggle sourceId="personen-toggler" targetId="personen-toggled"/>
      </jq:jquery>
      <div class="overview" id="personen-toggled">
        <div class="box">
          <div class="bold">Betreute</div>
          <g:link controller="clientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="clientProfile" action="list">Alle anzeigen (${allClients})</g:link></div>
          <div><g:link controller="clientProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Pädagogen</div>
          <g:link controller="educatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="educatorProfile" action="list">Alle anzeigen (${allEducators})</g:link></div>
          <div><g:link controller="educatorProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Erziehungsberechtigte</div>
          <g:link controller="parentProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="parentProfile" action="list">Alle anzeigen (${allParents})</g:link></div>
          <div><g:link controller="parentProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Kinder</div>
          <g:link controller="childProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="childProfile" action="list">Alle anzeigen (${allChilds})</g:link></div>
          <div><g:link controller="childProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Paten</div>
          <g:link controller="pateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="pateProfile" action="list">Alle anzeigen (${allPates})</g:link></div>
          <div><g:link controller="pateProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Partner</div>
          <g:link controller="partnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="partnerProfile" action="list">Alle anzeigen (${allPartners})</g:link></div>
          <div><g:link controller="partnerProfile" action="create">Neu anlegen</g:link></div>
        </div>
      </div>
      <div class="clear"></div>

      <h1>Andere <a href="#" id="andere-toggler">(ein-/ausblenden)</a></h1>
      <jq:jquery>
        <jq:toggle sourceId="andere-toggler" targetId="andere-toggled"/>
      </jq:jquery>
      <div class="overview" id="andere-toggled">
        <div class="box">
          <div class="bold">Einrichtungen</div>
          <g:link controller="facilityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="facilityProfile" action="list">Alle anzeigen (${allFacilities})</g:link></div>
          <div><g:link controller="facilityProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Ressourcen</div>
          <g:link controller="resourceProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="resourceProfile" action="list">Alle anzeigen (${allResources})</g:link></div>
          <div><g:link controller="resourceProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Gewichtungsmethoden</div>
          <g:link controller="method" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="method" action="list">Alle anzeigen (${allMethods})</g:link></div>
          <div><g:link controller="method" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Themen</div>
          <g:link controller="themeProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="themeProfile" action="list">Alle anzeigen (${allThemes})</g:link></div>
          <div><g:link controller="themeProfile" action="create">Neu anlegen</g:link></div>
        </div>
      </div>
      <div class="clear"></div>


      <h1>Gruppen <a href="#" id="gruppen-toggler">(ein-/ausblenden)</a></h1>
      <jq:jquery>
        <jq:toggle sourceId="gruppen-toggler" targetId="gruppen-toggled"/>
      </jq:jquery>
      <div class="overview" id="gruppen-toggled">
        <div class="box">
          <div class="bold">Colonias</div>
          <g:link controller="groupColonyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupColonyProfile" action="list">Alle anzeigen (${allColonias})</g:link></div>
          <div><g:link controller="groupColonyProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Familien</div>
          <g:link controller="groupFamilyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupFamilyProfile" action="list">Alle anzeigen (${allFamilies})</g:link></div>
          <div><g:link controller="groupFamilyProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Sponsorennetzwerke</div>
          <g:link controller="groupPartnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupPartnerProfile" action="list">Alle anzeigen (${allPartnerGroups})</g:link></div>
          <div><g:link controller="groupPartnerProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Betreutengruppen</div>
          <g:link controller="groupClientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupClientProfile" action="list">Alle anzeigen (${allClientGroups})</g:link></div>
          <div><g:link controller="groupClientProfile" action="create">Neu anlegen</g:link></div>
        </div>
      </div>
      <div class="clear"></div>

      <h1>Planung <a href="#" id="planung-toggler">(ein-/ausblenden)</a></h1>
      <jq:jquery>
        <jq:toggle sourceId="planung-toggler" targetId="planung-toggled"/>
      </jq:jquery>
      <div class="overview" id="planung-toggled">
        <div class="box">
          <div class="bold">Aktivitätsvorlagen</div>
          <g:link controller="template" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="template" action="list">Alle anzeigen (${allActivityTemplates})</g:link></div>
          <div><g:link controller="template" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">AV-Blöcke</div>
          <g:link controller="groupActivityTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityTemplateProfile" action="list">Alle anzeigen (${allActivityTemplateGroups})</g:link></div>
          <div><g:link controller="groupActivityTemplateProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">A-Blöcke</div>
          <g:link controller="groupActivityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityProfile" action="list">Alle anzeigen (${allActivityGroups})</g:link></div>
          %{--<div><g:link controller="groupActivityProfile" action="create">Neu anlegen</g:link></div>--}%
        </div>
        <div class="box">
          <div class="bold">Projektvorlagen</div>
          <g:link controller="projectTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="projectTemplateProfile" action="list">Alle anzeigen (${allProjectTemplates})</g:link></div>
          <div><g:link controller="projectTemplateProfile" action="create">Neu anlegen</g:link></div>
        </div>
        <div class="box">
          <div class="bold">Projekte</div>
          <img src="${g.resource(dir:'images/icons', file:'notes.png')}" alt="Notiz" align="top"/>
          <div>Alle anzeigen (0)</div>
          %{--<div>Neu anlegen</div>--}%
        </div>
      </div>
      <div class="clear"></div>

    </div>

</div>
</body>