<div id="banner-private">

  <div id="imgmenu">
    <ol>
      <li>
        <div class="imgbox">
          <g:link controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">
            <img src="${g.resource(dir: 'images/icons', file: 'kf_profil.png')}" alt="<g:message code="imgmenu.profile.name"/>"/>
            <h3><g:message code="imgmenu.profile.name"/></h3>
          </g:link>
        </div>
      </li>

      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']">
        <li>
          <div class="imgbox">
            <g:link controller="templateProfile" action="index">
              <img src="${g.resource(dir: 'images/icons', file: 'kf_aktivitaetsvorlage.png')}" alt="<g:message code="imgmenu.template.name"/>"/>
              <h3><g:message code="imgmenu.template.name"/></h3>
            </g:link>
          </div>
        </li>

        <li>
          <div class="imgbox">
            <g:link controller="groupActivityTemplateProfile" action="list">
              <img src="${g.resource(dir: 'images/icons', file: 'kf_aktivitaetsblockvorlage.png')}" alt="<g:message code="imgmenu.activityTemplate.name"/>"/>
              <h3><g:message code="imgmenu.activityTemplate.name"/></h3>
            </g:link>
          </div>
        </li>

        <li>
          <div class="imgbox">
            <g:link controller="projectTemplateProfile" action="list">
              <img src="${g.resource(dir: 'images/icons', file: 'kf_projektvorlage.png')}" alt="<g:message code="imgmenu.projects.name"/>"/>
              <h3><g:message code="imgmenu.projects.name"/></h3>
            </g:link>
          </div>
        </li>

        <g:if test="${grailsApplication.config.project == 'sueninos'}">
            <li>
              <div class="imgbox">
                <g:link controller="activityProfile" action="list">
                  <img src="${g.resource(dir: 'images/icons', file: 'kf_themenraum.png')}" alt="<g:message code="imgmenu.activity.name"/>"/>
                  <h3><g:message code="imgmenu.activity.name"/></h3>
                </g:link>
              </div>
            </li>
        </g:if>
      </erp:accessCheck>

      <li>
        <div class="imgbox">
          <g:link controller="calendar" action="show">
            <img src="${g.resource(dir: 'images/icons', file: 'kf_kalender.png')}" alt="<g:message code="imgmenu.calendar.name"/>"/>
            <h3><g:message code="imgmenu.calendar.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div class="imgbox">
          <g:link controller="themeProfile" action="list">
            <img src="${g.resource(dir: 'images/icons', file: 'kf_themen.png')}" alt="<g:message code="imgmenu.theme.name"/>"/>
            <h3><g:message code="imgmenu.theme.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div class="imgbox">
          <g:link controller="overview" action="index" id="${currentEntity.id}">
            <img src="${g.resource(dir: 'images/icons', file: 'kf_ueberblick.png')}" alt="<g:message code="imgmenu.overview.name"/>"/>
            <h3><g:message code="imgmenu.overview.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div class="imgbox">
          <g:link controller="helper" id="${currentEntity.id}">
            <img src="${g.resource(dir: 'images/icons', file: 'help.png')}" alt="<g:message code="privat.head.help"/>"/>
            <h3><g:message code="privat.head.help"/></h3>
          </g:link>
        </div>
      </li>

    </ol>
  </div>
</div>