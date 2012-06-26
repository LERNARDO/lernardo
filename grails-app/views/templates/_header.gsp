<g:link controller="app" action="start"><div id="logo">${grailsApplication.config.application.name}</div><img src="${resource(dir: '/images/' + grailsApplication.config.customer, file:  'logo.png')}" height="50px" alt="${grailsApplication.config.customer}" style="position: relative; top: 10px;"/></g:link>
<div id="info">

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

    <g:link class="tooltip" data-tooltip="${message(code: 'favorites')}" controller="favorite" action="list">
      <span id="favtooltip" class="notificationbox inactive" style="border-right: none;">
        <img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="Favorites" style="position: relative; top: 3px;"/>
      </span>
    </g:link>

  </span>

  <span id="other">

    <span class="box">
      <g:link controller="profile" action="changeLanguage" params="[locale: 'de_DE']"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></g:link> <g:link controller="profile" action="changeLanguage" params="[locale: 'es_ES']"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/></g:link> <g:link controller="profile" action="changeLanguage" params="[locale: 'en_GB']"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></g:link>
      <g:link class="tooltip" data-tooltip="${message(code: 'privat.head.help')}" controller="helper"><img src="${g.resource(dir:'images/icons', file:'icon_help.png')}" alt="Help" style="position: relative; top: 2px;"/></g:link>
    </span>
    <span class="box">
      <g:link class="me" controller="${currentEntity.type.supertype.name + 'Profile'}" action="show" id="${currentEntity.id}"><erp:profileImage entity="${currentEntity}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 3px 10px;"/> ${currentEntity?.profile?.fullName}</g:link>
    </span>
    <span class="box" style="border-right: none;">
      <a href="#" onclick="$('#options').toggle(); return false;"><img src="${g.resource(dir:'images/icons', file:'bullet_arrow_down.png')}" alt="Options" style="position: relative; top: 3px;"/></a>
    </span>
    <div id="options" style="display: none; padding: 5px; background: #ddd; border: 1px solid #bbb; position: absolute; top: 52px; right: 25px;"><g:link controller="app" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" style="position: relative; top: 3px;"/> <g:message code="header.logOut"/></g:link></div>
  </span>

</div>