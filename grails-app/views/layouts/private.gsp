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
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}" type="text/javascript"></script>

  <script type="text/javascript">
    $(document).ready(function() {

      $('.countable50').jqEasyCounter({
        'maxChars': 50,
        'maxCharsWarning': 50
      });

      $('.countable500').jqEasyCounter({
        'maxChars': 500,
        'maxCharsWarning': 500
      });

      $('.countable2000').jqEasyCounter({
        'maxChars': 2000,
        'maxCharsWarning': 2000
      });

    });
  </script>

  <script type="text/javascript">
    <!--
    function changeTab (aktiv_tab, aktiv_inhalt, passiv_tab, passiv_inhalt) {
        document.getElementById(aktiv_tab).className = "aktiv_tab";
        document.getElementById(aktiv_inhalt).className = "aktiv_inhalt";
        document.getElementById(passiv_tab).className = "passiv_tab";
        document.getElementById(passiv_inhalt).className = "passiv_inhalt";
    }
    -->
  </script>

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
            <h1>${entity.profile.fullName} <g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource(dir: 'images/icons', file: 'bullet_green.png')}" alt="aktiv" style="top: 3px; position: relative"/></g:if><g:else><img src="${resource(dir: 'images/icons', file: 'bullet_red.png')}" alt="inaktiv"/></g:else></g:if> <a href="#" id="kommunikation-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}" style="top: 3px; position: relative"></a>
            </h1>
          </div>
        </div>

        <div class="profile-box">
          <div class="second">
            <jq:jquery>
              <jq:toggle sourceId="kommunikation-toggler" targetId="kommunikation-toggled"/>
            </jq:jquery>
            <div id="kommunikation-toggled">

              <table>
                <tr>
                  <td width="135">
                    <ub:profileImage name="${entity.name}" width="130"/>
                  </td>
                  <td>
                    <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="true">
                    %{--<app:isMe entity="${entity}">--}%
                      <ul>
                        <li class="icon-person"><g:link controller="profile" action="uploadprf" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
                      </ul>
                    %{--</app:isMe>--}%
                    </app:hasRoleOrType>

                    <ul>
                      <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="privat.profile"/></g:link></li>
                      <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}"><g:message code="privat.docs"/></g:link></li>
                      <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="yes">
                        <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}"><g:message code="privat.events"/></g:link></li>
                      </app:hasRoleOrType>

                      <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="[]" me="true">
                        <app:hasRoleOrType entity="${currentEntity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                          <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link> <app:getNewInboxMessages entity="${entity}"/></li>
                        </app:hasRoleOrType>
                        <app:hasRoleOrType entity="${currentEntity}" roles="[]" types="['Pädagoge']" me="false">
                          <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}"><g:message code="privat.articleList"/></g:link></li>
                        </app:hasRoleOrType>
                      </app:hasRoleOrType>

                      <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                        <app:notMe entity="${entity}">
                          <g:if test="${entity.user.enabled}">
                            <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link></li>
                          </g:if>

                        </app:notMe>
                      </app:hasRoleOrType>
                    </ul>
                  </td>

                </tr>

              </table>

            </div>
          </div>
        </div>
      %{--this concerns myself = currentEntity --}%
        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber','User']" me="false">

          <div class="profile-box">
            <div class="second">
              %{--Menue links Administration / Verwaltung--}%
              <div class="header">
                <label id="tab-verwaltung" class="aktiv_tab" onclick="changeTab('tab-verwaltung', 'inhalt-verwaltung', 'tab-admin', 'inhalt-admin')"><g:message code="privat.head.verw"/>&nbsp;&nbsp;|</label>
                <label id="tab-admin" class="passiv_tab" onclick="changeTab('tab-admin', 'inhalt-admin', 'tab-verwaltung', 'inhalt-verwaltung')"><g:message code="privat.head.admin"/> &nbsp;</label>

                &nbsp;<a href="#" id="administration-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>
              <jq:jquery>
                <jq:toggle sourceId="administration-toggler" targetId="administration-toggled"/>
              </jq:jquery>
              <div id="administration-toggled">
                <div id="inhalt-admin" class="passiv_inhalt">
                  <ul>

                    <li class="icon-admin"><g:link controller="profile" action="createNotification"><g:message code="notifications"/></g:link></li>
                    <app:isAdmin>
                      <li class="icon-admin"><g:link controller="method" action="index" params="[name:entity.name]"><g:message code="vMethods"/></g:link></li>
                    </app:isAdmin>

                  </ul>
                </div>

                <div id="inhalt-verwaltung" class="aktiv_inhalt">
                  <ul>
                    <app:isAdmin>
                      <li class="icon-admin"><g:link controller="profile" action="list" params="[name:entity.name]"><g:message code="profiles"/></g:link></li>
                      <li class="icon-admin"><g:link controller="operatorProfile" action="list" params="[name:entity.name]"><g:message code="operator"/></g:link></li>
                      <li class="icon-admin"><g:link controller="userProfile" action="list" params="[name:entity.name]"><g:message code="user"/></g:link></li>
                      <hr/>
                    </app:isAdmin>
                    <li class="icon-admin"><g:link controller="educatorProfile" action="index" params="[name:entity.name]"><g:message code="educators"/></g:link></li>
                    <li class="icon-admin"><g:link controller="clientProfile" action="index" params="[name:entity.name]"><g:message code="clients"/></g:link></li>
                    <li class="icon-admin"><g:link controller="childProfile" action="index" params="[name:entity.name]"><g:message code="children"/></g:link></li>
                    <li class="icon-admin"><g:link controller="parentProfile" action="index" params="[name:entity.name]"><g:message code="parents"/></g:link></li>
                    <li class="icon-admin"><g:link controller="pateProfile" action="index" params="[name:entity.name]"><g:message code="paten"/></g:link></li>
                    <li class="icon-admin"><g:link controller="partnerProfile" action="index" params="[name:entity.name]"><g:message code="partners"/></g:link></li>
                    <hr/>
                    <li class="icon-admin"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]"><g:message code="groupFamilies"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]"><g:message code="groupColonies"/></g:link></li>
                    <li class="icon-admin"><g:link controller="facilityProfile" action="index" params="[name:entity.name]"><g:message code="facility"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]"><g:message code="groupClients"/></g:link></li>
                    <li class="icon-admin"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]"><g:message code="groupPartners"/></g:link></li>

                  </ul>
                </div>

              </div>
            </div>
          </div>
        </app:hasRoleOrType>



        <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
          <div class="profile-box">
            <div class="second">
              %{--Menue links Personen--}%
              <div class="header">
                <g:message code="privat.head.paedag"/> &nbsp;&nbsp;
                <a href="#" id="paedag-toggler"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a></div>

              <jq:jquery>
                <jq:toggle sourceId="paedag-toggler" targetId="paedag-toggled"/>
              </jq:jquery>
              <div id="paedag-toggled">
                <div id="a1" class="ein">
                  <ul>
                    <app:isOperator entity="${currentEntity}">
                      <li class="icon-admin"><g:link controller="resourceProfile" action="index" params="[name:entity.name]"><g:message code="resources"/></g:link></li>
                    </app:isOperator>
                  </ul>
                </div>

              </div>
            </div>
          </div>
        </app:hasRoleOrType>


      %{--   <app:hasRoleOrType entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">   --}%

        <div class="profile-box">
          <div class="second">
            %{--Menue links Hilfe--}%
            <div class="header"><g:message code="privat.head.help"/></div>
            <ul>
              <li class="icon-help"><g:link controller="helper" id="${entity.id}"><g:message code="privat.showHelp"/></g:link></li>
            </ul>
          </div>
        </div>
        %{--  </app:hasRoleOrType> --}%

      </div><!-- profile-navigation-->
    </div><!--bd-->

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>
  </div><!-- doc4 -->
</div><!-- private -->
</body>
</html>