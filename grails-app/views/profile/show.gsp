<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil von ${profileInstance.profile.fullName}</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <div id="profile-pic">
            <ub:profileImage name="${profileInstance.name}" width="180" height="233" />
          </div>

          <ub:meOrAdmin entityName="${profileInstance.name}">
            <li><g:link controller="asset" action="uploadprf" params="[entity:profileInstance.name]">Profilbild ändern</g:link></li>
          </ub:meOrAdmin>
          %{--<g:render template="picturebox" model="[name:profileInstance.fullName+' - '+profileInstance.role,
                    type:profileInstance.type, imageUrl:profileInstance.image]"/>--}%

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <li class="profile-neuigkeiten"><g:link action="show" params="[content:'neuigkeiten',name:profileInstance.name]">Neuigkeiten</g:link></li>
              <li class="profile-profil"><g:link action="show" params="[content:'profile',name:profileInstance.name]">Profil ansehen</g:link></li>
              <ub:meOrAdmin entityName="${profileInstance?.name}">
                <li class="profile-nachricht"><g:link controller="msg" action="inbox">Mein Postfach</g:link></li>
              </ub:meOrAdmin>             
              <g:if test="${profileInstance.type == 'paed' || profileInstance.type == 'client'}">
                <li class="profile-telefon"><g:link action="show" params="[content:'sms',name:profileInstance.name]">SMS senden</g:link></li>
                <li class="profile-activities"><g:link action="show" params="[content:'activities',name:profileInstance.name]">Aktivitäten ansehen</g:link></li>
              </g:if>
              <li class="profile-calendar"><g:link action="show" params="[content:'calendar',name:profileInstance.name]">Kalender ansehen</g:link></li>
              <g:if test="${profileInstance.type == 'einrichtung'}">
                <li class="profile-location"><g:link action="show" params="[content:'location',name:profileInstance.name]">Standort anzeigen</g:link></li>
              </g:if>
              <g:if test="${profileInstance.type == 'client'}">
                <li class="profile-leistung"><g:link action="show" params="[content:'leistung',name:profileInstance.name]">Leistungsfortschritt</g:link></li>
              </g:if>

              <ub:notMe entityName="${profileInstance?.name}">
                <li class="profile-nachricht"><g:link controller="msg" action="create" params="[name:profileInstance.name]">Nachricht senden</g:link></li>
                <app:isFriend entity="${profileInstance}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="removeFriend" params="[name:profileInstance?.name]">Vom Netzwerk entfernen</g:link></li>
                </app:isFriend>
                <app:notFriend entity="${profileInstance}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="addFriend" params="[name:profileInstance?.name]">Zum Netzwerk hinzufügen</g:link></li>
                </app:notFriend>
              </ub:notMe>
            </ul>
          </div>

          <div class="profile-group">Netzwerk</div>
          <div class="profile-box">
            <g:if test="${friendsList.size() == 0}">
              Keine Freunde im Netzwerk
            </g:if>
            <g:else>
            <ul>
              <g:each in="${friendsList}" var="friend">
                <li><g:link action="show" params="[content:'profile',name:friend.name]">${friend.profile.fullName}</g:link> (<app:getRelationship source="${profileInstance.name}" target="${friend.name}"/>)</li>
              </g:each>
            </ul>
            </g:else>
          </div>
        </div>

        <g:if test="${content == 'neuigkeiten'}">
          <g:render template="/profile/content-neuigkeiten" />
        </g:if>
        <g:if test="${content == 'calendar'}">
          <g:render template="/profile/content-calendar" model="${profileInstance}" />
        </g:if>
        <g:elseif test="${content == 'message'}">
          <g:render template="/profile/content-message" />
        </g:elseif>
        <g:elseif test="${content == 'sms'}">
          <g:render template="/profile/content-sms" />
        </g:elseif>
        <g:elseif test="${content == 'activities'}">
          <g:render template="/profile/content-activities" model="${activityList}" />
        </g:elseif>
        <g:elseif test="${content == 'location'}">
          <g:render template="/profile/content-location" model="[profileInstance:profileInstance,location:location]" />
        </g:elseif>
        <g:elseif test="${content == 'profile'}">
          <g:render template="/profile/content-profile" model="[profileInstance:profileInstance,entity:profileInstance]" />
        </g:elseif>
        <g:elseif test="${content == 'leistung'}">
          <g:render template="/profile/content-leistung" />
        </g:elseif>

      </div>
    </div>
      </div>

  </body>
</html>