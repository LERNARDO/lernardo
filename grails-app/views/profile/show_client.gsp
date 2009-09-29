<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil - Betreuter</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <g:render template="picturebox" model="[name:profileInstance.firstName+' '+profileInstance.lastName+' - '+profileInstance.role,
                    type:'client', imageUrl:profileInstance.image]"/>

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <g:def var="profileVar" value="${profileInstance.name}"/>
              <li class="profile-profil"><g:link action="show" params="[content:'profile',name:profileVar]">Profil ansehen</g:link></li>
              <li class="profile-nachricht"><g:link action="show" params="[content:'message',name:profileVar]">Nachricht schreiben</g:link></li>
              <li class="profile-telefon"><g:link action="show" params="[content:'sms',name:profileVar]">SMS senden</g:link></li>
              <li class="profile-calendar"><g:link action="show" params="[content:'calendar',name:profileVar]">Kalender ansehen</g:link></li>
              <li class="profile-activities"><g:link action="show" params="[content:'activities',name:profileVar]">Aktivitäten ansehen</g:link></li>
              <li class="profile-leistung"><a href="#">Leistungsfortschritt</a></li>
              <ub:notMe entityName="${profileInstance.name}">
                <li class="profile-netzwerk"><a href="#">Zu Netzwerk hinzufügen</a></li>
              </ub:notMe>
            </ul>
          </div>

          <div class="profile-group">Netzwerk</div>
          <div class="profile-box">
            <ul>
              <g:each in="${profileInstance.friends}" var="friend">
                <li><g:link action="show" params="[content:'profile',name:friend.key]">${friend.key[0].toUpperCase() + friend.key.substring(1)}</g:link> (${friend.value})</li>
              </g:each>
            </ul>
          </div>
        </div>

        <g:if test="${content == 'calendar'}">
          <g:render template="/templates/content-calendar" model="${profileInstance}" />
        </g:if>
        <g:else>
          <g:set var="profileInstance" value="${profileInstance}"/>
          <g:set var="activityList" value="${activityList}"/>
          <g:render template="/templates/client-content-${content}" model="[profileInstance:profileInstance,activityList:activityList]" />
        </g:else>

      </div>
    </div>

  </body>
</html>