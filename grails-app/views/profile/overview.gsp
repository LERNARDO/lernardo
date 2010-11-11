<head>
  <meta name="layout" content="private-cal"/>
  <title><g:message code="profile.overview"/></title>
</head>
<body>

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="profile.overview.glossary"/> <a onclick="toggle('#glossar-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
  </div>
</div>
<div class="boxGray" id="glossar-toggled">
  <div class="second" id="userlist-results">
    <p><g:message code="profile.overview.glossaryLabel"/></p>
    <g:render template="glossary" model="[glossary: glossary]"/>
  </div>
</div>

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="profile.overview.search"/> <a onclick="toggle('#suche-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
  </div>
</div>
<div class="boxGray" id="suche-toggled">
  <div class="second">

    <div id="body-list">
      <g:message code="profile.overview.searchLabel"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'profile', action:'searchMe']" before="showspinner('#membersearch-results')" />

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

      <div class="membersearch-results" id="membersearch-results">
      </div>

    </div>
  </div>
</div>

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="profile.overview"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      %{--the first panel should only be visible to admins--}%
      <app:isAdmin>
        <h1><g:message code="profile.overview.admin"/> <a onclick="toggle('#admin-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
        <div class="overview" id="admin-toggled">
          <div class="box">
            <div class="bold"><g:message code="operator"/> (${allOperators})</div>
            <g:link controller="operatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreiber.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="operatorProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
            <div><g:link controller="operatorProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </div>
          <div class="box">
            <div class="bold"><g:message code="user"/> (${allUsers})</div>
            <g:link controller="userProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_user.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="userProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
            <div><g:link controller="userProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </div>
          <div class="box">
            <div class="bold"><g:message code="management"/></div>
            <g:link controller="profile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_verwaltung.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="profile" action="list" params="[name:currentEntity.name]"><g:message code="profile.overview.showAll"/></g:link></div>
            %{--<div><g:link controller="userProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>--}%
          </div>
        </div>
        <div class="clear"></div>
      </app:isAdmin>

      <h1><g:message code="profile.overview.persons"/> <a onclick="toggle('#personen-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <div class="overview" id="personen-toggled">
        <div class="box">
          <div class="bold"><g:message code="clients"/> (${allClients})</div>
          <g:link controller="clientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreuter.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="clientProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="clientProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="educators"/> (${allEducators})</div>
          <g:link controller="educatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paedagoge.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="educatorProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="educatorProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="parents"/> (${allParents})</div>
          <g:link controller="parentProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_erziehungsberechtigte.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="parentProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="parentProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="children"/> (${allChilds})</div>
          <g:link controller="childProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_kinder.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="childProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="childProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
        <g:if test="${grailsApplication.config.project == 'sueninos'}">
          <div class="box">
            <div class="bold"><g:message code="paten"/> (${allPates})</div>
            <g:link controller="pateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paten.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="pateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
            <app:isOperator entity="${currentEntity}">
              <div><g:link controller="pateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
            </app:isOperator>
          </div>
        </g:if>
        <div class="box">
          <div class="bold"><g:message code="partners"/> (${allPartners})</div>
          <g:link controller="partnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_partner.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="partnerProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="partnerProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
      </div>
      <div class="clear"></div>

      <h1><g:message code="profile.overview.others"/> <a onclick="toggle('#andere-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <div class="overview" id="andere-toggled">
        <div class="box">
          <div class="bold"><g:message code="facilities"/> (${allFacilities})</div>
          <g:link controller="facilityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_einrichtung.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="facilityProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isOperator entity="${currentEntity}">
            <div><g:link controller="facilityProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="resources"/> (${allResources})</div>
          <g:link controller="resourceProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_resourcen.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="resourceProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          %{--<app:isOperator entity="${currentEntity}">
            <div><g:link controller="resourceProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isOperator>--}%
        </div>
        <div class="box">
          <div class="bold"><g:message code="vMethods"/> (${allMethods})</div>
          <g:link controller="method" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_gewichtung.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="method" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isAdmin>
            <div><g:link controller="method" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isAdmin>
        </div>
        %{--<div class="box">
          <div class="bold">Themen (${allThemes})</div>
          <g:link controller="themeProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="themeProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          --}%%{-- only created by lead educator --}%%{--
          <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
            <div><g:link controller="themeProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:accessCheck>
        </div>--}%
      </div>
      <div class="clear"></div>


      <h1><g:message code="profile.overview.groups"/> <a onclick="toggle('#gruppen-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <div class="overview" id="gruppen-toggled">
        <div class="box">
          <div class="bold"><g:message code="groupColonies"/> (${allColonias})</div>
          <g:link controller="groupColonyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_colonia.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupColonyProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
            <div><g:link controller="groupColonyProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:accessCheck>
        </div>
        <div class="box">
          <div class="bold"><g:message code="groupFamilies"/> (${allFamilies})</div>
          <g:link controller="groupFamilyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_familie.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupFamilyProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
            <div><g:link controller="groupFamilyProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:accessCheck>
        </div>
        <g:if test="${grailsApplication.config.project == 'sueninos'}">
          <div class="box">
            <div class="bold"><g:message code="groupPartners"/> (${allPartnerGroups})</div>
            <g:link controller="groupPartnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_sponsorennetzwerk.png')}" alt="Notiz" align="top"/></g:link>
            <div><g:link controller="groupPartnerProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
            <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
              <div><g:link controller="groupPartnerProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
            </app:accessCheck>
          </div>
        </g:if>
        <div class="box">
          <div class="bold"><g:message code="groupClients"/> (${allClientGroups})</div>
          <g:link controller="groupClientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreutengruppe.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupClientProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
            <div><g:link controller="groupClientProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:accessCheck>
        </div>
      </div>
      <div class="clear"></div>

      <h1><g:message code="profile.overview.plan"/> <a onclick="toggle('#planung-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
      <div class="overview" id="planung-toggled">
        <div class="box">
          <div class="bold"><g:message code="activityTemplate"/> (${allActivityTemplates})</div>
          <g:link controller="templateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="templateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isEducator entity="${currentEntity}">
            <div><g:link controller="templateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="activityInstance"/> (${allActivities})</div>
          <g:link controller="activity" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themenraum.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="activity" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          %{--<div><g:link controller="template" action="create"><g:message code="profile.overview.createNew"/></g:link></div>--}%
        </div>
        <div class="box">
          <div class="bold"><g:message code="groupActivityTemplate"/> (${allActivityTemplateGroups})</div>
          <g:link controller="groupActivityTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblockvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityTemplateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isEducator entity="${currentEntity}">
            <div><g:link controller="groupActivityTemplateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="groupActivity"/> (${allActivityGroups})</div>
          <g:link controller="groupActivityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblock.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="groupActivityProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          %{--<div><g:link controller="groupActivityProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>--}%
        </div>
        <div class="box">
          <div class="bold"><g:message code="projectTemplate"/> (${allProjectTemplates})</div>
          <g:link controller="projectTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projektvorlage.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="projectTemplateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          <app:isEducator entity="${currentEntity}">
            <div><g:link controller="projectTemplateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:isEducator>
        </div>
        <div class="box">
          <div class="bold"><g:message code="projects"/> (${allProjects})</div>
          <g:link controller="projectProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projekte.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="projectProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          %{--<div><g:message code="profile.overview.createNew"/></div>--}%
        </div>
        <div class="box">
          <div class="bold"><g:message code="themes"/> (${allThemes})</div>
          <g:link controller="themeProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="Notiz" align="top"/></g:link>
          <div><g:link controller="themeProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
          %{-- only created by lead educator --}%
          <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
            <div><g:link controller="themeProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
          </app:accessCheck>
        </div>
      </div>
      <div class="clear"></div>

    </div>

</div>
</body>