<g:link controller="app" action="start"><div id="logo">${grailsApplication.config.application.name}</div><img src="${resource(dir: '/images/' + grailsApplication.config.customer, file:  'logo.png')}" height="50px" alt="${grailsApplication.config.customer}" style="position: relative; top: 10px;"/></g:link>
<div id="info">
  <g:form name="searchForm" controller="search" params="[child: 'yes', client: 'yes', educator: 'yes', facility: 'yes', operator: 'yes', parent: 'yes', partner: 'yes', pate: 'yes']">

    <span id="notifications">
      <erp:getNewInboxMessages entity="${currentEntity}">
        <g:link class="tooltip" data-tooltip="${message(code: 'privat.posts')}" controller="msg" action="inbox" id="${currentEntity.id}">
        <span class="notificationbox ${result > 0 ? 'active' : 'inactive'}">
          <g:if test="${result > 0}">
            <span class="white">${result}</span> <img src="${g.resource(dir:'images/icons', file:'icon_mail.png')}" alt="Mail" style="position: relative; top: 3px;"/>
          </g:if>
          <g:else>
            <span class="gray">${result}</span> <img src="${g.resource(dir:'images/icons', file:'icon_mail_off.png')}" alt="Mail" style="position: relative; top: 3px;"/>
          </g:else>
        </span>
        </g:link>
      </erp:getNewInboxMessages>

      %{--<erp:getNewNews entity="${currentEntity}">
        <g:link class="tooltip" data-tooltip="${message(code: 'newsp')}" controller="news" action="index" id="${currentEntity.id}">
        <span class="notificationbox inactive">
          <span class="gray">${result}</span> <img src="${g.resource(dir:'images/icons', file:'icon_text.png')}" alt="News" style="position: relative; top: 3px;"/>
        </span>
        </g:link>
      </erp:getNewNews>--}%

      <erp:getCurrentAppointments entity="${currentEntity}">
        <g:link class="tooltip" data-tooltip="${message(code: 'appointments')}" controller="appointmentProfile" action="list" id="${currentEntity.id}">
        <span class="notificationbox inactive">
          <span class="gray">${result}</span> <img src="${g.resource(dir:'images/icons', file:'icon_appointments.png')}" alt="Appointments" style="position: relative; top: 3px;"/>
        </span>
        </g:link>
      </erp:getCurrentAppointments>

      <g:link class="tooltip" data-tooltip="${message(code: 'imgmenu.calendar.name')}" controller="calendar" action="show">
        <span class="notificationbox inactive">
          <img src="${g.resource(dir:'images/icons', file:'icon_calendar.png')}" alt="Calendar" style="position: relative; top: 3px;"/>
        </span>
      </g:link>

      <a class="tooltip" data-tooltip="${message(code: 'favorites')}" href="#" onclick="togglefavs()">
        <span id="favtooltip" class="notificationbox inactive" style="border-right: none;">
          <img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="Favorites" style="position: relative; top: 3px;"/>
        </span>
      </a>

      <script type="text/javascript">
        function togglefavs() {
          var status = $('#favorites').css('display');
          if (status == 'none') {
            ${remoteFunction(controller: 'profile', action: 'updateFavorites', update: 'favorites')}
          }
          $('#favorites').toggle();
        }
      </script>

      <div id="favorites" style="display: none; background: #ddd; border: 1px solid #bbb; position: absolute; top: 52px; text-align: left;">
      </div>

    </span>

    <span id="other">
      <g:textField class="search" name="search" size="25" placeholder="${message(code: 'searchWord')}"/>
      <span class="searchButton"><g:submitButton name="searchButton" class="buttonBlue" value="${message(code: 'search')}"/></span>
      <span class="box">
        %{--<a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/></a> <a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a>--}%
        <g:link controller="profile" action="changeLanguage" params="[locale: 'de_DE']"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></g:link> <g:link controller="profile" action="changeLanguage" params="[locale: 'es_ES']"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/></g:link> <g:link controller="profile" action="changeLanguage" params="[locale: 'en_GB']"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></g:link>
        <g:link class="tooltip" data-tooltip="${message(code: 'privat.head.help')}" controller="helper" id="${currentEntity.id}"><img src="${g.resource(dir:'images/icons', file:'icon_help.png')}" alt="Help" style="position: relative; top: 2px;"/></g:link>
      </span>
      <span class="box">
        <g:link class="me" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}" params="[entity:currentEntity.id]"><erp:profileImage entity="${currentEntity}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 3px 10px;"/> ${currentEntity?.profile?.fullName}</g:link>
      </span>
      <span class="box" style="border-right: none;">
        %{--<g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" style="position: relative; top: 3px;"/></g:link>--}%
        <a href="#" onclick="$('#options').toggle(); return false;"><img src="${g.resource(dir:'images/icons', file:'bullet_arrow_down.png')}" alt="Options" style="position: relative; top: 3px;"/></a>
      </span>
      <div id="options" style="display: none; padding: 5px; background: #ddd; border: 1px solid #bbb; position: absolute; top: 52px; right: 25px;"><g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" style="position: relative; top: 3px;"/> <g:message code="header.logOut"/></g:link></div>
    </span>

  </g:form>
</div>