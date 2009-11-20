<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div id="doc4" class="yui-t3">
  <div id="bd">

    <div class="yui-b" id="profile-navigation">

      <div id="profile-pic">
        <h1>${entity.profile.fullName}</h1>
        <ub:profileImage name="${entity.name}" width="180" height="233"/>
      </div>

      <ub:meOrAdmin entityName="${entity.name}">
      <div class="profile-group">Persönliches</div>
        <div class="profile-box">
          <ul>
            <li><g:link controller="asset" action="uploadprf" params="[entity:entity.name]">Profilbild ändern</g:link></li>
            <li><g:link controller="asset" action="uploadprf" params="[entity:entity.name]">Profildaten ändern</g:link></li>
          </ul>
        </div>
      </ub:meOrAdmin>

      <div class="profile-group">Kommunikation</div>
      <div class="profile-box">
        <ul>
          <li class="profile-profil"><g:remoteLink action="showProfile" update="profile-content" params="[name:entity.name]">Profil ansehen</g:remoteLink></li>
          <ub:meOrAdmin entityName="${entity.name}">
            <li class="profile-neuigkeiten"><g:remoteLink action="showNews" update="profile-content" params="[name:entity.name]">Neuigkeiten</g:remoteLink></li>
            <li class="profile-nachricht"><g:remoteLink controller="msg" action="inbox" update="profile-content">Mein Postfach</g:remoteLink></li>
            <g:if test="${entity.type.name == 'Paed'}">
              <li class="profile-activities"><g:remoteLink controller="post" action="createArticlePost" update="profile-content" params="[name:entity.name]">Artikel schreiben</g:remoteLink></li>
            </g:if>
          </ub:meOrAdmin>
          <g:if test="${entity.type.name == 'Paed'}">
            <li class="profile-activities"><g:remoteLink action="showArticleList" update="profile-content" params="[name:entity.name]">Artikel ansehen</g:remoteLink></li>
          </g:if>
          <g:if test="${entity.type.name == 'Paed' || entity.type.name == 'Client'}">
          %{--<li class="profile-telefon"><g:remoteLink action="createSMS" update="profile-content" params="[name:entity.name]">SMS senden</g:remoteLink></li>--}%
            <li class="profile-activities"><g:remoteLink action="showActivityList" update="profile-content" params="[name:entity.name]">Aktivitäten ansehen</g:remoteLink></li>
          </g:if>
          <li class="profile-calendar"><g:remoteLink action="showCalendar" update="profile-content" params="[name:entity.name]">Kalender ansehen</g:remoteLink></li>
          <g:if test="${entity.type.name == 'Operator' || entity.type.name == 'Hort'}">
            <li class="profile-location"><g:remoteLink action="showLocation" update="profile-content" params="[name:entity.name]">Standort anzeigen</g:remoteLink></li>
          </g:if>
          <g:if test="${entity.type.name == 'Operator'}">
            <li class="profile-activities"><g:link action="createHort">Hort anlegen</g:link></li>
          </g:if>
          <g:if test="${entity.type.name == 'Hort'}">
            <li class="profile-activities"><g:link action="createPaed">Pädagoge anlegen</g:link></li>
            <li class="profile-activities"><g:link action="createClient">Betreuten anlegen</g:link></li>
          </g:if>
          <g:if test="${entity.type.name == 'Client'}">
            <li class="profile-leistung"><g:remoteLink action="showLeistung" update="profile-content" params="[name:entity.name]">Leistungsfortschritt</g:remoteLink></li>
          </g:if>

          <ub:notMe entityName="${entity.name}">
            <li class="profile-nachricht"><g:remoteLink controller="msg" action="create" update="profile-content" params="[name:entity.name]">Nachricht senden</g:remoteLink></li>
            <app:isFriend entity="${entity}">
              <li class="profile-netzwerk"><g:link controller="profile" action="removeFriend" params="[name:entity.name]">Vom Netzwerk entfernen</g:link></li>
            </app:isFriend>
            <app:notFriend entity="${entity}">
              <li class="profile-netzwerk"><g:link controller="profile" action="addFriend" params="[name:entity.name]">Zum Netzwerk hinzufügen</g:link></li>
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
              <li><g:link action="show" params="[content:'profile',name:friend.name]">${friend.profile.fullName}</g:link> (<app:getRelationship source="${entity.name}" target="${friend.name}"/>)</li>
            </g:each>
          </ul>
        </g:else>
      </div>
    </div>

    <div id="yui-main">
      <div class="yui-b">
        <div id="profile-content">
          <g:render template="showProfile" model="[entity:entity]"/>
        </div>
      </div>
    </div>

  </div><!--bd-->
</div><!--doc4-->

</body>
</html>