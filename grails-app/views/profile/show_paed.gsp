<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />


    <title>Profil - Pädagoge</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <g:render template="picturebox" model="[name:profileInstance.firstName+' '+profileInstance.lastName+' - '+profileInstance.role,
                                                  type:'paed', imageUrl:profileInstance.image]"/>

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <g:def var="profileVar" value="${profileInstance.name}"/>
              <li class="profile-profil"><g:link action="show" params="[content:'profile',name:profileVar]">Profil ansehen</g:link></li>
              <li class="profile-nachricht"><g:link action="show" params="[content:'message',name:profileVar]">Nachricht schreiben</g:link></li>
              <li class="profile-telefon"><g:link action="show" params="[content:'sms',name:profileVar]">SMS senden</g:link></li>
              <li class="profile-calendar"><g:link action="show" params="[content:'calendar',name:profileVar]">Kalender ansehen</g:link></li>
              <li class="profile-activities"><g:link action="show" params="[content:'activities',name:profileVar]">Aktivitäten ansehen</g:link></li>
              <li class="profile-netzwerk"><a href="#">Zu Netzwerk hinzufügen</a></li>
            </ul>
          </div>

          <div class="profile-group">Netzwerk</div>
          <div class="profile-box">
            <ul>
              <g:each in="${profileInstance.friends}" var="friend">
                <li><a href="/lernardoV2/prf/${friend.key}">${friend.key[0].toUpperCase() + friend.key.substring(1)}</a> (${friend.value})</li>
              </g:each>
            </ul>
          </div>
        </div>

        <g:if test="${content == 'calendar'}">
          <g:render template="/templates/content-calendar" model="${profileInstance}" />
        </g:if>
        <g:else>
          <g:render template="/templates/paed-content-${content}" model="${profileInstance}" />
        </g:else>

      </div>
    </div>

  </body>
</html>