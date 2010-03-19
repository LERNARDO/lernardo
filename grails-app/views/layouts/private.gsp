<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title><g:layoutTitle default="Lernardo"/></title>
  <link rel="stylesheet" href="${g.resource(dir: 'css', file: 'yui-reset-fonts-grids.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css" media="screen" charset="utf-8">
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:layoutHead/>
  <g:javascript library="jquery"/>
</head>
<body>
<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>
<div id="private">
  <div id="doc4" class="yui-t3">

    <div id="hd">
      <g:render template="/templates/header"/>
      <div id="nav">
        <g:render template="/templates/navigation"/>
      </div>
    </div>

    <div id="banner">
      <g:render template="/templates/imagenav"/>
    </div>

    <div id="bd">
      <div id="yui-main">
        <div id="main" class="yui-b">
          <g:if test="${flash.message}">
            <div id="flash-msg">
              ${flash.message}
            </div>
          </g:if>
          <div id="private-content">
            <g:layoutBody/>
          </div>
        </div>
      </div>

      <div id="profile-navigation" class="yui-b">

        <div id="profile-pic">
          <div class="name">
            <div class="second">
              ${entity.profile.fullName}
            </div>
          </div>
          <div id="picture">
            <ub:profileImage name="${entity.name}" width="180" height="180"/>
          </div>
          <div class="type" style="margin-top: -2px">
            <div class="second">
              ${entity.type.name}
            </div>
          </div>
        </div>

        <ub:meOrAdmin entityName="${entity.name}">
          <div class="profile-group"><div class="second">Profil</div></div>
          <div class="profile-box">
            <div class="second">
              <ul>
                <li class="icon-person"><g:link controller="asset" action="uploadprf">Bild ändern</g:link></li>
                <li class="icon-edit"><g:link controller="${entity.type.supertype.name +'Profile'}" action="edit" id="${entity.id}">Daten ändern</g:link></li>
              </ul>
            </div>
          </div>
        </ub:meOrAdmin>

        <div class="profile-group"><div class="second">Kommunikation</div></div>
        <div class="profile-box">
          <div class="second">
            <ul>
              <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">Profil ansehen</g:link></li>
              <ub:meOrAdmin entityName="${entity.name}">
                <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}">Ereignisse ansehen</g:link></li>
                <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}">Postfach ansehen</g:link> <app:getNewInboxMessages entity="${entity}"/></li>
              </ub:meOrAdmin>
              <app:isEducator entity="${entity}">
                <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}">Artikel ansehen</g:link></li>
              </app:isEducator>
              <g:if test="${entity.type.name == 'Educator' || entity.type.name == 'Client'}">
              %{--<li class="profile-telefon"><g:remoteLink action="createSMS" update="profile-content" params="[name:entity.name]">SMS senden</g:remoteLink></li>--}%
                <li class="profile-activities"><g:link controller="profile" action="showActivityList" id="${entity.id}">Aktivitäten ansehen</g:link></li>
              </g:if>
              %{--<li class="profile-calendar"><g:link controller="profile" action="showCalendar" id="${entity.id}">Kalender ansehen</g:link></li>--}%
              <g:if test="${entity.type.name == 'Operator' || entity.type.name == 'Facility'}">
              %{--<li class="profile-location"><g:link controller="profile" action="showLocation" id="${entity.id}">Standort anzeigen</g:link></li>--}%
              </g:if>
              <g:if test="${entity.type.name == 'Educator'}">
                <li class="profile-leistung"><g:link controller="evaluation" id="${entity.id}">Leistungsbeurteilung ansehen</g:link></li>
              </g:if>

              <app:notMe entity="${entity}">
                <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}">Nachricht senden</g:link></li>
                <app:isFriend entity="${entity}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="removeFriend" id="${entity.id}">Als Freund entfernen</g:link></li>
                </app:isFriend>
                <app:notFriend entity="${entity}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="addFriend" id="${entity.id}">Als Freund hinzufügen</g:link></li>
                </app:notFriend>
                <app:isBookmark entity="${entity}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="removeBookmark" id="${entity.id}">Bookmark entfernen</g:link></li>
                </app:isBookmark>
                <app:notBookmark entity="${entity}">
                  <li class="profile-netzwerk"><g:link controller="profile" action="addBookmark" id="${entity.id}">Bookmark setzen</g:link></li>
                </app:notBookmark>
              </app:notMe>
            </ul>
          </div>
        </div>

        <ub:meOrAdmin entityName="${entity.name}">
          <div class="profile-group"><div class="second">Pädagogik</div></div>
          <div class="profile-box">
            <div class="second">
              <ul>
                <app:isEducator entity="${entity}">
                  <li class="profile-template"><g:link controller="template" action="create">Aktivitätsvorlage erstellen</g:link></li>
                </app:isEducator>
                %{--<app:isFacility entity="${entity}">
                  <li class="profile-activities"><g:link controller="profile" action="attendance" id="${entity.id}">Anwesenheits-/Essenslisten</g:link></li>
                </app:isFacility>--}%
              </ul>
            </div>
          </div>
        </ub:meOrAdmin>

        <div class="profile-group"><div class="second">Administration</div></div>
        <div class="profile-box">
          <div class="second">
            <ul>
              <app:isAdmin>
                <li class="icon-admin"><g:link controller="profile" action="createNotification">Notifikation erstellen</g:link></li>
                <li class="icon-admin" style="border-bottom: 1px solid #999"><g:link controller="profile" action="list" params="[name:entity.name]">Alle Profile verwalten</g:link></li>
              %{--<li><g:link controller="adm" action="index">Verwaltung</g:link></li>--}%
              </app:isAdmin>
              <app:isSysAdmin>
                <li class="icon-admin" style="border-top: 1px solid #fff; padding-top: 2px"><g:link controller="operatorProfile" action="index" params="[name:entity.name]">Betreiber verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="userProfile" action="index" params="[name:entity.name]">User verwalten</g:link></li>
              </app:isSysAdmin>
              <app:isOperator entity="${entity}">
                <li class="icon-admin"><g:link controller="educatorProfile" action="index" params="[name:entity.name]">Pädagogen verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="clientProfile" action="index" params="[name:entity.name]">Betreute verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="pateProfile" action="index" params="[name:entity.name]">Paten verwalten</g:link></li>
                <li class="icon-admin" style="border-bottom: 1px solid #999"><g:link controller="parentProfile" action="index" params="[name:entity.name]">Erziehungsberechtigte verwalten</g:link></li>
                <li class="icon-admin" style="border-top: 1px solid #eee; padding-top: 2px"><g:link controller="facilityProfile" action="index" params="[name:entity.name]">Einrichtungen verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="partnerProfile" action="index" params="[name:entity.name]">Partner verwalten</g:link></li>
                %{--<li class="icon-admin"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]">Familien verwalten (Gruppierung)</g:link></li>--}%
              </app:isOperator>
              <app:isEducator entity="${entity}">
                <li class="icon-admin"><g:link controller="resourceProfile" action="index">Ressourcen verwalten</g:link></li>
              </app:isEducator>
            </ul>
          </div>
        </div>

        <div class="profile-group"><div class="second">Hilfe</div></div>
        <div class="profile-box">
          <div class="second">
            <ul>
              <li class="icon-help"><g:link controller="helper" id="${entity.id}">Hilfethemen anzeigen</g:link></li>
            </ul>
          </div>
        </div>

        %{--            <div class="profile-group">Netzwerk</div>
        <div class="profile-box">
          <g:if test="${!friendsList}">
            Keine Freunde im Netzwerk
          </g:if>
          <g:else>
            <ul>
              <g:each in="${friendsList}" var="friend">
                <li><g:link action="show" params="[content:'profile',name:friend.name]">${friend.profile.fullName}</g:link> (<app:getRelationship source="${entity.name}" target="${friend.name}"/>)</li>
              </g:each>
            </ul>
          </g:else>
        </div>--}%

      </div><!-- profile-navigation-->
    </div><!--bd-->

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>
  </div><!-- doc4 -->
</div><!-- private -->
</body>
</html>