<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title><g:layoutTitle default="Lernardo" /></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${createLinkTo(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:layoutHead />
    <g:javascript library="jquery"/>
  </head>
  <body>
    <div id="private">
      <div id="doc4" class="yui-t3">
        <div id="hd">
          <g:render template="/templates/header" />
          <div id="nav">
            <g:render template="/templates/navigation" />
          </div>
        </div>
        <div id="banner">
          <ol class="imgmenu">
            <li>
              <div id="member" class="imgbox">
                <g:link controller="profile" action="showProfile" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'profile.png')}" alt="Profile" />
                  <h3>Mein Profil</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="paeds" class="imgbox">
                <g:link controller="template" action="list" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'activities.png')}" alt="Aktivitätsvorlagen" />
                  <h3>Aktivitätsvorlagen</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="activities" class="imgbox">
                <g:link controller="activity" action="list" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'all_activities.png')}" alt="Aktivitäten" />
                  <h3>Aktivitäten</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="orga" class="imgbox">
                <g:link controller="calendar" action="showall" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'calendar.png')}" alt="Kalender" />
                  <h3>Kalender</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="profiles" class="imgbox">
                <g:link controller="profile" action="search" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'profiles.png')}" alt="Suche" />
                  <h3>Suche</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="admin" class="imgbox">
                <g:link controller="network" action="index" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'admin.png')}" alt="Netzwerk" />
                  <h3>Netzwerk</h3>
                </g:link>
              </div>
            </li>
            
          </ol>
        </div>

        <div id="bd">
          <div id="yui-main">
            <div id="main" class="yui-b">
              <g:if test="${flash.message}">
                <div id="flash-msg">
                  ${flash.message}
                </div>
              </g:if>
              <div id="profile-content">
                <g:layoutBody />
              </div>
            </div>
          </div>

          <div id="profile-navigation" class="yui-b">
            <div id="profile-pic">
              <h1>${entity.profile.fullName}</h1>
              <ub:profileImage name="${entity.name}" width="180" height="233"/>
            </div>

            <ub:meOrAdmin entityName="${entity.name}">
            <div class="profile-group">Persönliches</div>
              <div class="profile-box">
                <ul>
                  <li><g:link controller="asset" action="uploadprf" params="[entity:entity.name]">Profilbild ändern</g:link></li>
                  <g:if test="${entity.type.supertype.name == 'Person'}">
                    <li><g:remoteLink action="edit" update="profile-content" params="[name:entity.name]">Profildaten ändern</g:remoteLink></li>
                  </g:if>
                  <g:else>
                    <li><g:remoteLink action="editFacility" update="profile-content" params="[name:entity.name]">Profildaten ändern</g:remoteLink></li>
                  </g:else>
                </ul>
              </div>
            </ub:meOrAdmin>

            <div class="profile-group">Kommunikation</div>
            <div class="profile-box">
              <ul>
                <li class="profile-profil"><g:link controller="profile" action="showProfile" params="[name:entity.name]">Profil ansehen</g:link></li>
                <ub:meOrAdmin entityName="${entity.name}">
                  <li class="profile-neuigkeiten"><g:link controller="profile" action="showNews" params="[name:entity.name]">Neuigkeiten</g:link></li>
                  <li class="profile-nachricht"><g:link controller="msg" action="inbox" params="[name:entity.name]">Mein Postfach</g:link> <app:getNewInboxMessages entityName="${entity.name}"/></li>
                </ub:meOrAdmin>
                <g:if test="${entity.type.name == 'Paed'}">
                  <li class="profile-activities"><g:link controller="profile" action="showArticleList" params="[name:entity.name]">Artikel ansehen</g:link></li>
                  <li class="profile-activities"><g:link controller="profile" action="attendance" params="[name:entity.name]">Anwesenheits-/Essenslisten</g:link></li>
                </g:if>
                <g:if test="${entity.type.name == 'Paed' || entity.type.name == 'Client'}">
                %{--<li class="profile-telefon"><g:remoteLink action="createSMS" update="profile-content" params="[name:entity.name]">SMS senden</g:remoteLink></li>--}%
                  <li class="profile-activities"><g:link controller="profile" action="showActivityList" params="[name:entity.name]">Aktivitäten ansehen</g:link></li>
                </g:if>
                <li class="profile-calendar"><g:link controller="profile" action="showCalendar" params="[name:entity.name]">Kalender ansehen</g:link></li>
                <g:if test="${entity.type.name == 'Operator' || entity.type.name == 'Hort'}">
                  <li class="profile-location"><g:link controller="profile" action="showLocation" params="[name:entity.name]">Standort anzeigen</g:link></li>
                </g:if>
                <g:if test="${entity.type.name == 'Operator'}">
                  <li class="profile-activities"><g:link controller="profile" action="createHort" params="[name:entity.name]">Hort anlegen</g:link></li>
                </g:if>
                <g:if test="${entity.type.name == 'Hort'}">
                  <li class="profile-activities"><g:link controller="profile" action="createClient" params="[name:entity.name]">Betreuten anlegen</g:link></li>
                </g:if>
                <g:if test="${entity.type.name == 'Client'}">
                  <li class="profile-leistung"><g:link controller="profile" action="showLeistung" params="[name:entity.name]">Leistungsfortschritt</g:link></li>
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
                  <li class="profile-template"><g:link controller="template" action="create">Aktivitätsvorlage erstellen</g:link></li>
                </ul>
              </div>
          </ub:meOrAdmin>

          <ub:isAdmin entityName="${entity.name}">
            <div class="profile-group">Administration</div>
              <div class="profile-box">
                <ul>
                  <li class="profile-person"><g:link controller="profile" action="list">Alle Profile anzeigen</g:link></li>
                  <li class="profile-person"><g:link controller="profile" action="createOperator">Betreiber anlegen</g:link></li>
                  <li class="profile-person"><g:link controller="profile" action="createPaed">Pädagoge anlegen</g:link></li>
                </ul>
              </div>
          </ub:isAdmin>

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