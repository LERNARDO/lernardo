<head>
  <meta name="layout" content="private-cal"/>
  <title>Übersicht</title>
</head>
<body>

<div class="headerGreen">
  <div class="second">
    <h1>Glossar <a href="#" id="glossar-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
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

<div class="headerGreen">
  <div class="second">
    <h1>Suche <a href="#" id="suche-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
    %{--<script type="text/javascript">

      $(document).ready(function() {
          $("#membersearch-results").bind("ajaxSend", function() {
              //$(this).fadeIn();
            $(this).update('<img src="${createLinkTo(dir:'images',file:'spinner.gif')}" border="0" alt="Loading..." title="Loading..." width="16" height="16" />');}
            }).bind("ajaxComplete", function() {
              $(this).fadeOut();
          }
      );

     </script>--}%
  </div>
</div>
<jq:jquery>
  <jq:toggle sourceId="suche-toggler" targetId="suche-toggled"/>
</jq:jquery>
<div class="boxGray" id="suche-toggled">
  <div class="second">

    <div id="body-list">
      Bitte einen Namen eingeben: <g:remoteField name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'profile', action:'searchMe']" />

      %{-- previous implementation - left here in case the instant search runs into performance issues at some point --}%
      
      %{--<g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
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
      </g:formRemote>--}%

      <div id="spinner" class="spinner" style="display:none;">
<img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
</div>
      <div class="membersearch-results" id="membersearch-results">
      </div>

    </div>
  </div>
</div>

<div class="headerGreen">
  <div class="second">
    <h1>Übersicht</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      %{--the first panel should only be visible to admins--}%
      <app:isAdmin>
        <h1>Admin <a href="#" id="admin-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
        <jq:jquery>
          <jq:toggle sourceId="admin-toggler" targetId="admin-toggled"/>
        </jq:jquery>
        <div class="overview" id="admin-toggled">
          <div class="box">
            <div class="bold">Betreiber (${allOperators})</div>
            <g:link controller="operatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreiber.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="operatorProfile" action="list">Alle anzeigen</g:link></div>
            <div><g:link controller="operatorProfile" action="create">Neu anlegen</g:link></div>
          </div>
          <div class="box">
            <div class="bold">User (${allUsers})</div>
            <g:link controller="userProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_user.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="userProfile" action="list">Alle anzeigen</g:link></div>
            <div><g:link controller="userProfile" action="create">Neu anlegen</g:link></div>
          </div>
          <div class="box">
            <div class="bold">Verwaltung</div>
            <g:link controller="profile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_verwaltung.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="profile" action="list" params="[name:entity.name]">Alle anzeigen</g:link></div>
            %{--<div><g:link controller="userProfile" action="create">Neu anlegen</g:link></div>--}%
          </div>
        </div>
        <div class="clear"></div>
      </app:isAdmin>

      <h1>Personen <a href="#" id="personen-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <jq:jquery>
        <jq:toggle sourceId="personen-toggler" targetId="personen-toggled"/>
      </jq:jquery>
      <div class="overview" id="personen-toggled">
        <div class="box">
          <div class="bold">Betreute (${allClients})</div>
          <g:link controller="clientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreuter.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="clientProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="clientProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Pädagogen (${allEducators})</div>
          <g:link controller="educatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paedagoge.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="educatorProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="educatorProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Erziehungsberechtigte (${allParents})</div>
          <g:link controller="parentProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_erziehungsberechtigte.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="parentProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="parentProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Kinder (${allChilds})</div>
          <g:link controller="childProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_kinder.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="childProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="childProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Paten (${allPates})</div>
          <g:link controller="pateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paten.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="pateProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="pateProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Partner (${allPartners})</div>
          <g:link controller="partnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_partner.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="partnerProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="partnerProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
      </div>
      <div class="clear"></div>

      <h1>Andere <a href="#" id="andere-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <jq:jquery>
        <jq:toggle sourceId="andere-toggler" targetId="andere-toggled"/>
      </jq:jquery>
      <div class="overview" id="andere-toggled">
        <div class="box">
          <div class="bold">Einrichtungen (${allFacilities})</div>
          <g:link controller="facilityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_einrichtung.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="facilityProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="facilityProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Ressourcen (${allResources})</div>
          <g:link controller="resourceProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_resourcen.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="resourceProfile" action="list">Alle anzeigen</g:link></div>
          <app:isOperator entity="${entity}">
            <div><g:link controller="resourceProfile" action="create">Neu anlegen</g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold">Gewichtungsmethoden (${allMethods})</div>
          <g:link controller="method" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_gewichtung.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="method" action="list">Alle anzeigen</g:link></div>
          <app:isAdmin>
            <div><g:link controller="method" action="create">Neu anlegen</g:link></div>
          </app:isAdmin>
        </div>
        <div class="box">
          <div class="bold">Themen (${allThemes})</div>
          <g:link controller="themeProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="themeProfile" action="list">Alle anzeigen</g:link></div>
          %{-- only created by lead educator --}%
          <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
            <div><g:link controller="themeProfile" action="create">Neu anlegen</g:link></div>
          </app:hasRoleOrType>
        </div>
      </div>
      <div class="clear"></div>


      <h1>Gruppen <a href="#" id="gruppen-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <jq:jquery>
        <jq:toggle sourceId="gruppen-toggler" targetId="gruppen-toggled"/>
      </jq:jquery>
      <div class="overview" id="gruppen-toggled">
        <div class="box">
          <div class="bold">Colonias (${allColonias})</div>
          <g:link controller="groupColonyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_colonia.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupColonyProfile" action="list">Alle anzeigen</g:link></div>
          <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
            <div><g:link controller="groupColonyProfile" action="create">Neu anlegen</g:link></div>
          </app:hasRoleOrType>
        </div>
        <div class="box">
          <div class="bold">Familien (${allFamilies})</div>
          <g:link controller="groupFamilyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_familie.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupFamilyProfile" action="list">Alle anzeigen</g:link></div>
          <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
            <div><g:link controller="groupFamilyProfile" action="create">Neu anlegen</g:link></div>
          </app:hasRoleOrType>
        </div>
        <div class="box">
          <div class="bold">Sponsorennetzwerke (${allPartnerGroups})</div>
          <g:link controller="groupPartnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_sponsorennetzwerk.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupPartnerProfile" action="list">Alle anzeigen</g:link></div>
          <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
            <div><g:link controller="groupPartnerProfile" action="create">Neu anlegen</g:link></div>
          </app:hasRoleOrType>
        </div>
        <div class="box">
          <div class="bold">Betreutengruppen (${allClientGroups})</div>
          <g:link controller="groupClientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreutengruppe.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupClientProfile" action="list">Alle anzeigen</g:link></div>
          <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
            <div><g:link controller="groupClientProfile" action="create">Neu anlegen</g:link></div>
          </app:hasRoleOrType>
        </div>
      </div>
      <div class="clear"></div>

      <h1>Planung <a href="#" id="planung-toggler"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <jq:jquery>
        <jq:toggle sourceId="planung-toggler" targetId="planung-toggled"/>
      </jq:jquery>
      <div class="overview" id="planung-toggled">
        <div class="box">
          <div class="bold">Aktivitätsvorlagen (${allActivityTemplates})</div>
          <g:link controller="templateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="templateProfile" action="list">Alle anzeigen</g:link></div>
          <app:isEducator entity="${entity}">
            <div><g:link controller="templateProfile" action="create">Neu anlegen</g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold">Themenraumaktivitäten (${allActivities})</div>
          <g:link controller="activity" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themenraum.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="activity" action="list">Alle anzeigen</g:link></div>
          %{--<div><g:link controller="template" action="create">Neu anlegen</g:link></div>--}%
        </div>
        <div class="box">
          <div class="bold">Aktivitätsblockvorlagen (${allActivityTemplateGroups})</div>
          <g:link controller="groupActivityTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblockvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityTemplateProfile" action="list">Alle anzeigen</g:link></div>
          <app:isEducator entity="${entity}">
            <div><g:link controller="groupActivityTemplateProfile" action="create">Neu anlegen</g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold">Aktivitätsblöcke (${allActivityGroups})</div>
          <g:link controller="groupActivityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblock.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityProfile" action="list">Alle anzeigen</g:link></div>
          %{--<div><g:link controller="groupActivityProfile" action="create">Neu anlegen</g:link></div>--}%
        </div>
        <div class="box">
          <div class="bold">Projektvorlagen (${allProjectTemplates})</div>
          <g:link controller="projectTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projektvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="projectTemplateProfile" action="list">Alle anzeigen</g:link></div>
          <app:isEducator entity="${entity}">
            <div><g:link controller="projectTemplateProfile" action="create">Neu anlegen</g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold">Projekte (${allProjects})</div>
          <g:link controller="projectProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projekte.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="projectProfile" action="list">Alle anzeigen</g:link></div>
          %{--<div>Neu anlegen</div>--}%
        </div>
      </div>
      <div class="clear"></div>

    </div>

</div>
</body>