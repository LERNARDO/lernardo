<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Sueninos - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${g.resource(dir: 'css', file: 'yui-reset-fonts-grids.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css" media="screen" charset="utf-8">
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:layoutHead/>
  <g:javascript library="jquery"/>
  <script src="${g.resource (dir:'js', file:'lernardo.js')}" type="text/javascript"></script>
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

    <div id="banner-private">
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
            <div style="position: absolute; top: 37px; right: 62px"><g:link controller="asset" action="uploadprf"><img src="${resource (dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:link></div>
            <div style=""><ub:profileImage name="${entity.name}" width="180" height="233"/></div>
            <div class="clear"></div>
          </div>
          <div class="type" style="margin-top: -2px">
            <div class="second">
              ${entity.type.name}
            </div>
          </div>
        </div>

        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">
              <div class="header">Profil</div>
              <ul>
                <li class="icon-person"><g:link controller="asset" action="uploadprf">Bild ändern</g:link></li>
              </ul>
            </div>
          </div>
        </app:hasRoleOrType>

        <div class="profile-box">
          <div class="second">
            <div class="header">Kommunikation</div>
            <ul>
              <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">Profil ansehen</g:link></li>
              <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}">Dokumente ansehen</g:link></li>

              <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="yes">
                <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}">Ereignisse ansehen</g:link></li>
              </app:hasRoleOrType>

              <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="[]" me="true">
                <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                  <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}">Postfach ansehen</g:link> <app:getNewInboxMessages entity="${entity}"/></li>
                </app:hasRoleOrType>
                <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge']" me="false">
                  <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}">Artikel ansehen</g:link></li>
                </app:hasRoleOrType>
              </app:hasRoleOrType>

              <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                <app:notMe entity="${entity}">
                  <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]">Nachricht senden</g:link></li>
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
              </app:hasRoleOrType>
            </ul>
          </div>
        </div>

        <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">
              <div class="header">Pädagogik</div>
              <ul>
                <li class="profile-template"><g:link controller="templateProfile" action="index">Aktivitätsvorlagen verwalten</g:link></li>
                <li class="profile-template"><g:link controller="groupActivityTemplateProfile" action="index">Aktivitätsblockvorlagen verwalten</g:link></li>
                <li class="profile-template"><g:link controller="groupActivityProfile" action="index">Aktivitätsblöcke verwalten</g:link></li>
                <li class="profile-template"><g:link controller="projectTemplateProfile" action="index">Projektvorlagen verwalten</g:link></li>
              </ul>
            </div>
          </div>
        </app:hasRoleOrType>

        <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
        <div class="profile-box">
          <div class="second">
            <div class="header">Administration</div>
            <ul>
              <app:isAdmin>
                <li class="icon-admin"><g:link controller="profile" action="createNotification">Notifikation erstellen</g:link></li>
                <li class="icon-admin"><g:link controller="profile" action="list" params="[name:entity.name]">Alle Profile verwalten</g:link></li>
              </app:isAdmin>
              <app:isSysAdmin>
                <li class="icon-admin"><g:link controller="operatorProfile" action="index" params="[name:entity.name]">Betreiber verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="userProfile" action="index" params="[name:entity.name]">User verwalten</g:link></li>
              </app:isSysAdmin>
              <app:isOperator entity="${entity}">
                <li class="icon-admin"><g:link controller="educatorProfile" action="index" params="[name:entity.name]">Pädagogen verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="clientProfile" action="index" params="[name:entity.name]">Betreute verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="childProfile" action="index" params="[name:entity.name]">Kinder verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="pateProfile" action="index" params="[name:entity.name]">Paten verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="parentProfile" action="index" params="[name:entity.name]">Erziehungsberechtigte verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="facilityProfile" action="index" params="[name:entity.name]">Einrichtungen verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="partnerProfile" action="index" params="[name:entity.name]">Partner verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]">Familien verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]">Colonias verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]">Betreutengruppen verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]">Sponsorennetzwerke verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="method" action="index" params="[name:entity.name]">Bewertungsmethoden verwalten</g:link></li>
                <li class="icon-admin"><g:link controller="themeProfile" action="index" params="[name:entity.name]">Themen verwalten</g:link></li>
              </app:isOperator>
              <app:isEducator entity="${entity}">
                <li class="icon-admin"><g:link controller="resourceProfile" action="index">Ressourcen verwalten</g:link></li>
              </app:isEducator>
            </ul>
          </div>
        </div>
        </app:hasRoleOrType>

        <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
        <div class="profile-box">
          <div class="second">
            <div class="header">Hilfe</div>
            <ul>
              <li class="icon-help"><g:link controller="helper" id="${entity.id}">Hilfethemen anzeigen</g:link></li>
            </ul>
          </div>
        </div>
        </app:hasRoleOrType>

      </div><!-- profile-navigation-->
    </div><!--bd-->

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>
  </div><!-- doc4 -->
</div><!-- private -->
</body>
</html>