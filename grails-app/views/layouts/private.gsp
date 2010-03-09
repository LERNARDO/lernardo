<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title><g:layoutTitle default="Lernardo" /></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${createLinkTo(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:layoutHead />
    <g:javascript library="jquery" />
  </head>
  <body>
    <g:if test="${!entity}">
      <g:set var="entity" value="${currentEntity}"/>
    </g:if>
    <div id="private">
      <div id="doc4" class="yui-t3">
        <div id="hd">
          <g:render template="/templates/header" />
          <div id="nav">
            <g:render template="/templates/navigation" />
          </div>
        </div>
        <div id="banner">
          <g:render template="/templates/imagenav" />
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
                <g:layoutBody />
              </div>
            </div>
          </div>

          <div id="profile-navigation" class="yui-b">
            <div id="profile-pic">
              <h1>
                ${entity.profile.fullName}
                <div class="subheader">${entity.type.name}</div>
              </h1>
              <div id="picture">
                <ub:profileImage name="${entity.name}" width="180" height="180"/>
              </div>
            </div>

            <ub:meOrAdmin entityName="${entity.name}">
            <div class="profile-group">Profil</div>
              <div class="profile-box">
                <ul>
                  <li class="icon-person"><g:link controller="asset" action="uploadprf" params="[entity:entity.name]">Bild ändern</g:link></li>
                  <g:if test="${entity.type.supertype.name == 'Person'}">
                    <li class="icon-edit"><g:link controller="profile" action="edit" params="[name:entity.name]">Daten ändern</g:link></li>
                  </g:if>
                  <g:else>
                    <li class="icon-edit"><g:link controller="profile" action="editFacility" params="[name:entity.name]">Daten ändern</g:link></li>
                  </g:else>
                </ul>
              </div>
            </ub:meOrAdmin>

            <div class="profile-group">Kommunikation</div>
            <div class="profile-box">
              <ul>
                <li class="profile-profil"><g:link controller="profile" action="showProfile" params="[name:entity.name]">Profil ansehen</g:link></li>
                <ub:meOrAdmin entityName="${entity.name}">
                  <li class="icon-news"><g:link controller="profile" action="showNews" params="[name:entity.name]">Ereignisse ansehen</g:link></li>
                  <li class="profile-nachricht"><g:link controller="msg" action="inbox" params="[name:entity.name]">Postfach ansehen</g:link> <app:getNewInboxMessages entityName="${entity.name}"/></li>
                </ub:meOrAdmin>
                <app:isPaed entity="${entity}">
                  <li class="profile-activities"><g:link controller="profile" action="showArticleList" params="[name:entity.name]">Artikel ansehen</g:link></li>
                </app:isPaed>
                <g:if test="${entity.type.name == 'Paed' || entity.type.name == 'Client'}">
                %{--<li class="profile-telefon"><g:remoteLink action="createSMS" update="profile-content" params="[name:entity.name]">SMS senden</g:remoteLink></li>--}%
                  <li class="profile-activities"><g:link controller="profile" action="showActivityList" params="[name:entity.name]">Aktivitäten ansehen</g:link></li>
                </g:if>
                <li class="profile-calendar"><g:link controller="profile" action="showCalendar" params="[name:entity.name]">Kalender ansehen</g:link></li>
                <g:if test="${entity.type.name == 'Operator' || entity.type.name == 'Facility'}">
                  %{--<li class="profile-location"><g:link controller="profile" action="showLocation" params="[name:entity.name]">Standort anzeigen</g:link></li>--}%
                </g:if>
                <g:if test="${entity.type.name == 'Client'}">
                  <li class="profile-leistung"><g:link controller="evaluation" params="[name:entity.name]">Leistungsbeurteilung ansehen</g:link></li>
                </g:if>

                <ub:notMe entityName="${entity.name}">
                  <li class="profile-nachricht"><g:link controller="msg" action="create" params="[name:entity.name]">Nachricht senden</g:link></li>
                  <app:isFriend entity="${entity}">
                    <li class="profile-netzwerk"><g:link controller="profile" action="removeFriend" params="[name:entity.name]">Als Freund entfernen</g:link></li>
                  </app:isFriend>
                  <app:notFriend entity="${entity}">
                    <li class="profile-netzwerk"><g:link controller="profile" action="addFriend" params="[name:entity.name]">Als Freund hinzufügen</g:link></li>
                  </app:notFriend>
                  <app:isBookmark entity="${entity}">
                    <li class="profile-netzwerk"><g:link controller="profile" action="removeBookmark" params="[name:entity.name]">Bookmark entfernen</g:link></li>
                  </app:isBookmark>
                  <app:notBookmark entity="${entity}">
                    <li class="profile-netzwerk"><g:link controller="profile" action="addBookmark" params="[name:entity.name]">Bookmark setzen</g:link></li>
                  </app:notBookmark>
                </ub:notMe>
              </ul>
            </div>

          <ub:meOrAdmin entityName="${entity.name}">
            <div class="profile-group">Pädagogik</div>
            <div class="profile-box">
              <ul>
                <app:isPaed entity="${entity}">
                  <li class="profile-template"><g:link controller="template" action="create">Aktivitätsvorlage erstellen</g:link></li>
                </app:isPaed>
                <app:isFacility entity="${entity}">
                  <li class="profile-activities"><g:link controller="profile" action="attendance" params="[name:entity.name]">Anwesenheits-/Essenslisten</g:link></li>
                </app:isFacility>
              </ul>
            </div>
          </ub:meOrAdmin>

          <div class="profile-group">Administration</div>
          <div class="profile-box">
            <ul>
              <app:isSysAdmin>
                <li><g:link controller="adm" action="createOperator" params="[name:entity.name]">Betreiber anlegen</g:link></li>
              </app:isSysAdmin>
              <ub:isAdmin>
                <li><g:link controller="profile" action="list" params="[name:entity.name]">Alle Profile anzeigen</g:link></li>
                %{--<li><g:link controller="profile" action="createPaed" params="[name:entity.name]">Pädagoge anlegen</g:link></li>
                <li><g:link controller="profile" action="createSchool" params="[name:entity.name]">Schule anlegen</g:link></li>--}%
                <li><g:link controller="adm" action="index">Verwaltung</g:link></li>
                <li><g:link controller="adm" action="createNotification">Notifikation erstellen</g:link></li>
              </ub:isAdmin>
              <app:isOperator entity="${entity}">
                <li class="icon-admin"><g:link controller="facilityProfile" action="index" params="[name:entity.name]">Einrichtungen verwalten</g:link></li>
                %{--<li class="icon-admin"><g:link controller="profile" action="createClient" params="[name:entity.name]">Betreute verwalten</g:link></li>--}%
                <li class="icon-admin"><g:link controller="partnerProfile" action="index" params="[name:entity.name]">Partner verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="pateProfile" action="index" params="[name:entity.name]">Paten verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="parentProfile" action="index" params="[name:entity.name]">Erziehungsberechtigte verwalten</g:link></li>
              </app:isOperator>
              <app:isPaed entity="${entity}">
                <li class="icon-admin"><g:link controller="resourceProfile" action="index" params="[name:entity.name]">Ressourcen verwalten</g:link></li>
              </app:isPaed>
            </ul>
          </div>

            <div class="profile-group">Hilfe</div>
              <div class="profile-box">
                <ul>
                  <li class="icon-help"><g:link controller="helper" params="[name:entity.name]">Hilfethemen anzeigen</g:link></li>
                </ul>
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
          <g:render template="/templates/footer" />
        </div>
      </div><!-- doc4 -->
    </div><!-- private -->
  </body>
</html>