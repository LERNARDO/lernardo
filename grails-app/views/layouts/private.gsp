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
  <script src="${g.resource(dir: 'js', file: 'lernardo.js')}" type="text/javascript"></script>
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
        <!--
        <div id="profile-pic">
          <div class="name">
            <div class="second">
              ${entity.profile.fullName}
            </div>
          </div>
          <div id="picture">
            <div style="position: absolute; top: 37px; right: 62px"><g:link controller="asset" action="uploadprf"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link></div>
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
        -->
        <div class="headerGreen">
          <div class="second">
            <h1>${entity.profile.fullName} <a href="#" id="kommunikation-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a>
            </h1>
          </div>
        </div>

        <div class="profile-box">
          <div class="second">
            <jq:jquery>
              <jq:toggle sourceId="kommunikation-toggler" targetId="kommunikation-toggled"/>
            </jq:jquery>
            <div id="kommunikation-toggled">
              <div id="profile-pic">
                <div class="name">
                  <div class="second">
                    ${entity.profile.fullName}
                  </div>
                </div>
                <div id="picture">
                  %{--<div style="position: absolute; top: 45px; right: 62px"><g:link controller="asset" action="uploadprf"><img src="${resource (dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}"/></g:link></div>--}%
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
                <ul>
                  <li class="icon-person"><g:link controller="asset" action="uploadprf"><g:message code="privat.picture.change"/></g:link></li>
                </ul>
              </app:hasRoleOrType>

              <ul>
                <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}"><g:message code="privat.profile"/></g:link></li>
                <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}"><g:message code="privat.docs"/></g:link></li>

              %{--this concerns the entity we are currently looking at = entity --}%
                <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="yes">
                  <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}"><g:message code="privat.events"/></g:link></li>
                </app:hasRoleOrType>

              %{--this concerns the entity we are currently looking at = entity --}%
                <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="[]" me="true">
                  <app:hasRoleOrType entity="${currentEntity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                    <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link> <app:getNewInboxMessages entity="${entity}"/></li>
                  </app:hasRoleOrType>
                  <app:hasRoleOrType entity="${currentEntity}" roles="[]" types="['Pädagoge']" me="false">
                    <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}">Artikel ansehen</g:link></li>
                  </app:hasRoleOrType>
                </app:hasRoleOrType>

              %{--this concerns the entity we are currently looking at = entity --}%
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
        </div>

      %{--this concerns myself = currentEntity --}%
        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">

          <div class="profile-box">
            <div class="second">

              <div class="header"><g:message code="privat.head.admin"/>&nbsp; &nbsp;<a href="#" id="administration-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>
              <jq:jquery>
                <jq:toggle sourceId="administration-toggler" targetId="administration-toggled"/>
              </jq:jquery>
              <div id="administration-toggled">
                <ul>
                  <app:isAdmin>
                    <li class="icon-admin"><g:link controller="profile" action="createNotification">Notifikation</g:link></li>
                    <li class="icon-admin"><g:link controller="profile" action="list" params="[name:entity.name]">Alle Profile</g:link></li>
                  </app:isAdmin>
                  <app:isSysAdmin>
                    <li class="icon-admin"><g:link controller="operatorProfile" action="index" params="[name:entity.name]"><g:message code="operator"/></g:link></li>
                    <li class="icon-admin"><g:link controller="userProfile" action="index" params="[name:entity.name]"><g:message code="user"/></g:link></li>
                  </app:isSysAdmin>

                </ul>
              </div>
            </div>
          </div>
        </app:hasRoleOrType>


        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">

              <div class="header"><g:message code="privat.head.plan"/> &nbsp; &nbsp;<a href="#" id="paedagogik-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>

              <jq:jquery>
                <jq:toggle sourceId="paedagogik-toggler" targetId="paedagogik-toggled"/>
              </jq:jquery>
              <div id="paedagogik-toggled">
                <ul>
                  <app:isEducator entity="${currentEntity}">
                    <li class="profile-template"><g:link controller="templateProfile" action="index"><g:message code="activities"/></g:link></li>
                    <li class="profile-template"><g:link controller="groupActivityTemplateProfile" action="index"><g:message code="groupActivity"/></g:link></li>
                    <li class="profile-template"><g:link controller="projectTemplateProfile" action="index"><g:message code="projects"/></g:link></li>
                  </app:isEducator>
                </ul>
              </div>
            </div>
          </div>
        </app:hasRoleOrType>

        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">

              <div class="header"><g:message code="privat.head.pers"/>&nbsp; &nbsp;<a href="#" id="personen-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>

              <jq:jquery>
                <jq:toggle sourceId="personen-toggler" targetId="personen-toggled"/>
              </jq:jquery>
              <div id="personen-toggled">
                <ul>

                  <app:isOperator entity="${currentEntity}">

                    <li class="icon-admin"><g:link controller="clientProfile" action="index" params="[name:entity.name]"><g:message code="clients"/></g:link></li>
                    <li class="icon-admin"><g:link controller="educatorProfile" action="index" params="[name:entity.name]"><g:message code="educators"/></g:link></li>
                    <li class="icon-admin"><g:link controller="parentProfile" action="index" params="[name:entity.name]"><g:message code="parents"/></g:link></li>
                    <li class="icon-admin"><g:link controller="childProfile" action="index" params="[name:entity.name]"><g:message code="children"/></g:link></li>
                    <li class="icon-admin"><g:link controller="pateProfile" action="index" params="[name:entity.name]"><g:message code="paten"/></g:link></li>
                    <li class="icon-admin"><g:link controller="partnerProfile" action="index" params="[name:entity.name]">Partner</g:link></li>

                  </app:isOperator>
                </ul>
              </div>
            </div>
          </div>
        </app:hasRoleOrType>

        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">

              <div class="header"><g:message code="privat.head.others"/>&nbsp; &nbsp;<a href="#" id="andere-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>

              <jq:jquery>
                <jq:toggle sourceId="andere-toggler" targetId="andere-toggled"/>
              </jq:jquery>
              <div id="andere-toggled">
                <ul>
                  <app:isOperator entity="${currentEntity}">
                    <li class="icon-admin"><g:link controller="facilityProfile" action="index" params="[name:entity.name]"><g:message code="facilities"/></g:link></li>
                    <app:isOperator entity="${currentEntity}">
                      <app:isEducator entity="${currentEntity}">
                        <li class="icon-admin"><g:link controller="resourceProfile" action="index"><g:message code="resources"/></g:link></li>
                      </app:isEducator>
                    </app:isOperator>
                    <li class="icon-admin"><g:link controller="method" action="index" params="[name:entity.name]"><g:message code="vMethods"/></g:link></li>
                    <li class="icon-admin"><g:link controller="themeProfile" action="index" params="[name:entity.name]"><g:message code="children"/>Themen</g:link></li>
                  </app:isOperator>

                </ul>
              </div>
            </div>
          </div>
        </app:hasRoleOrType>

        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="true">
          <div class="profile-box">
            <div class="second">

              <div class="header"><g:message code="privat.head.groups"/>&nbsp; &nbsp;<a href="#" id="gruppen-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>

              <jq:jquery>
                <jq:toggle sourceId="gruppen-toggler" targetId="gruppen-toggled"/>
              </jq:jquery>
              <div id="gruppen-toggled">
                <ul>
                  <app:isOperator entity="${currentEntity}">
                    <li class="icon-admin"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]"><g:message code="groupColonies"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]"><g:message code="groupFamilies"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]"><g:message code="groupPartners"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]"><g:message code="groupClients"/></g:link></li>
                  </app:isOperator>

                </ul>
              </div>
            </div>
          </div>
        </app:hasRoleOrType>





        <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
          <div class="profile-box">
            <div class="second">
              <div class="header"><g:message code="privat.head.help"/></div>
              <ul>
                <li class="icon-help"><g:link controller="helper" id="${entity.id}"><g:message code="privat.showHelp"/></g:link></li>
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