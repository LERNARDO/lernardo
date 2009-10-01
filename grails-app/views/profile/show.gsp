<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil von ${profileInstance.fullName}</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <g:render template="picturebox" model="[name:profileInstance.fullName+' - '+profileInstance.role,
                    type:profileInstance.type, imageUrl:profileInstance.image]"/>

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <li class="profile-profil"><g:link action="show" params="[content:'profile',name:profileInstance.name]">Profil ansehen</g:link></li>
              <li class="profile-nachricht"><g:link action="show" params="[content:'message',name:profileInstance.name]">Nachricht schreiben</g:link></li>
              <g:if test="${profileInstance.type == 'paed' || profileInstance.type == 'client'}">
                <li class="profile-telefon"><g:link action="show" params="[content:'sms',name:profileInstance.name]">SMS senden</g:link></li>
                <li class="profile-activities"><g:link action="show" params="[content:'activities',name:profileInstance.name]">Aktivitäten ansehen</g:link></li>
              </g:if>
              <li class="profile-calendar"><g:link action="show" params="[content:'calendar',name:profileInstance.name]">Kalender ansehen</g:link></li>
              <g:if test="${profileInstance.type == 'einrichtung'}">
                <li class="profile-location"><g:link action="show" params="[content:'location',name:profileInstance.name]">Standort anzeigen</g:link></li>
              </g:if>
              <g:if test="${profileInstance.type == 'client'}">
                <li class="profile-leistung"><a href="#">Leistungsfortschritt</a></li>
              </g:if>
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
        <g:elseif test="${content == 'message'}">
          <g:render template="/templates/content-message" />
        </g:elseif>
        <g:elseif test="${content == 'sms'}">
          <g:render template="/templates/content-sms" />
        </g:elseif>
        <g:elseif test="${content == 'activities'}">
          <g:render template="/templates/content-activities" model="${activityList}" />
        </g:elseif>
        <g:elseif test="${content == 'location'}">
          <g:render template="/templates/content-location" />
        </g:elseif>
        <g:elseif test="${content == 'profile'}">>
          <g:render template="/templates/content-profile" model="${profileInstance}" />
        </g:elseif>

      </div>
    </div>

  </body>
</html>