<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">

%{--
future HTML5 doctype
<!DOCTYPE html>
--}%

<html>
<head>
  %{-- <meta charset="utf-8" /> future HTML5 encoding--}%
  <title>${grailsApplication.config.projectName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${g.resource(dir: 'css', file: 'yui-reset-fonts-grids.css')}" type="text/css">
  <g:set var="project" value="${grailsApplication.config.project}"/>
  <link rel="stylesheet" href="${resource(dir: 'css/' + project, file: 'layout.css')}" type="text/css" media="screen" charset="utf-8">
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:layoutHead/>
  <g:javascript library="jquery" plugin="jquery"/>
  <jqui:resources/>
  <script src="${g.resource(dir: 'js', file: 'lernardo.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon-0.6.2.js')}" type="text/javascript"></script>

  <script type="text/javascript">
    $(document).ready(function() {

      $(".datepicker-birthday").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd. mm. yy',
        minDate: new Date(1900, 1, 1),
        maxDate: new Date(),
        firstDay: 1,
        yearRange: 'c-99:c+99',
        showMonthAfterYear: true,
        appendText: ' (DD. MM. YYYY)',
        autoSize: true});

      $(".datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd. mm. yy',
        minDate: new Date(1900, 1, 1),
        firstDay: 1});

      $('.datetimepicker').datetimepicker({
        dateFormat: 'dd. mm. yy'
      });

      $('#flash-msg').delay(3000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

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

  <ga:trackPageviewAsynch/>

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

    <div style="background: #fff;">
      <div id="banner-private">
        <g:render template="/templates/imagenav"/>
      </div>
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
        <div class="headerGreen">
          <div class="second">
            <h1>${entity.profile.fullName} <g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource(dir: 'images/icons', file: 'bullet_green.png')}" alt="aktiv" style="top: 3px; position: relative"/></g:if><g:else><img src="${resource(dir: 'images/icons', file: 'bullet_red.png')}" alt="inaktiv"/></g:else></g:if> %{--<a onclick="toggle('#kommunikation-toggled');
            return false" href="#"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}" style="top: 3px; position: relative"></a>--}%
            </h1>
          </div>
        </div>

        <div class="profile-box" style="border-top-left-radius: 0; border-top-right-radius: 0">
          <div class="second">
            <div id="kommunikation-toggled">

              <table>
                <tr>
                  <td style="width: 135px">
                    <ub:profileImage name="${entity.name}" width="130"/>
                  </td>
                  <td>

                    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="true">
                      <ul>
                        <li class="icon-person"><g:link controller="profile" action="uploadprf" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
                      </ul>
                    </app:accessCheck>

                    <ul>
                      <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="privat.profile"/></g:link></li>
                      <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}"><g:message code="privat.docs"/></g:link> <app:getPublicationCount entity="${entity}"/></li>

                      <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="true">
                        <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}"><g:message code="privat.events"/></g:link></li>
                      </app:accessCheck>

                      <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="[]" me="true">
                        <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                          <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link> <app:getNewInboxMessages entity="${entity}"/></li>
                        </app:accessCheck>
                        <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge']" me="false">
                          <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}"><g:message code="privat.articleList"/></g:link></li>
                        </app:accessCheck>
                      </app:accessCheck>

                      <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Betreuter','Kind','Betreiber','Pate','Partner','Erziehungsberechtigter','User']" me="false">
                        <app:notMe entity="${entity}">
                          <g:if test="${entity.user.enabled}">
                            <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link></li>
                          </g:if>
                        </app:notMe>
                      </app:accessCheck>

                      %{--TODO: find out why the check won't work here?!--}%
                      <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge']">
                        <app:accessCheck entity="${entity}" roles="[]" types="['Betreuter']">
                          <li class="icon-admin"><g:link controller="evaluation" action="list" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.evaluation"/></g:link></li>
                        </app:accessCheck>
                      </app:accessCheck>

                      <app:accessCheck entity="${entity}" roles="[]" types="['Einrichtung']">
                        <li class="icon-admin"><g:link controller="dayroutine" action="list" id="${entity.id}" params="[entity:entity.id]"><g:message code="dayroutine"/></g:link></li>
                      </app:accessCheck>

                    </ul>
                  </td>

                </tr>

              </table>

            </div>
          </div>
        </div>
      %{--this concerns myself = currentEntity --}%
        <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false">

          <div class="profile-box">
            <div class="second">

              %{--Menue links Administration / Verwaltung--}%
              <div class="header">
                <label id="tab-verwaltung" class="aktiv_tab" onclick="changeTab('tab-verwaltung', 'inhalt-verwaltung', 'tab-admin', 'inhalt-admin')"><g:message code="privat.head.verw"/>&nbsp;&nbsp;|</label>
                <label id="tab-admin" class="passiv_tab" onclick="changeTab('tab-admin', 'inhalt-admin', 'tab-verwaltung', 'inhalt-verwaltung')"><g:message code="privat.head.admin"/> &nbsp;</label>

                &nbsp;%{--<a onclick="toggle('#administration-toggled'); return false" href="#"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a>--}%</div>
                <div id="administration-toggled">

                  <div id="inhalt-admin" class="passiv_inhalt">
                    <ul>
                      <li class="profile-nachricht"><g:link controller="profile" action="createNotification"><g:message code="notifications"/></g:link></li>
                      <app:isAdmin>
                        <li class="icon-methods"><g:link controller="method" action="index" params="[name:entity.name]"><g:message code="vMethods"/></g:link></li>
                        <li class="icon-export"><g:link controller="transfer" action="index" params="[name:entity.name]">Import/Export</g:link></li>
                      </app:isAdmin>
                    </ul>
                  </div>

                  <div id="inhalt-verwaltung" class="aktiv_inhalt">
                    <ul>
                      <app:isOperator entity="${currentEntity}">
                        <li class="icon-all"><g:link controller="profile" action="list" params="[name:entity.name]"><g:message code="profiles"/></g:link></li>
                      </app:isOperator>
                      <app:isAdmin>
                        <li class="icon-operator"><g:link controller="operatorProfile" action="list" params="[name:entity.name]"><g:message code="operator"/></g:link></li>
                        <li class="icon-admin"><g:link controller="userProfile" action="list" params="[name:entity.name]"><g:message code="user"/></g:link></li>
                        <hr/>
                      </app:isAdmin>
                      <li class="icon-educators"><g:link controller="educatorProfile" action="index" params="[name:entity.name]"><g:message code="educators"/></g:link></li>
                      <li class="icon-person"><g:link controller="clientProfile" action="index" params="[name:entity.name]"><g:message code="clients"/></g:link></li>
                      <li class="icon-child"><g:link controller="childProfile" action="index" params="[name:entity.name]"><g:message code="children"/></g:link></li>
                      <li class="icon-parents"><g:link controller="parentProfile" action="index" params="[name:entity.name]"><g:message code="parents"/></g:link></li>
                      <g:if test="${grailsApplication.config.project == 'sueninos'}">
                        <li class="icon-pate"><g:link controller="pateProfile" action="index" params="[name:entity.name]"><g:message code="paten"/></g:link></li>
                      </g:if>
                      <li class="icon-partner"><g:link controller="partnerProfile" action="index" params="[name:entity.name]"><g:message code="partners"/></g:link></li>
                      <hr/>
                      <li class="icon-group"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]"><g:message code="groupFamilies"/></g:link></li>
                      <li class="icon-colony"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]"><g:message code="groupColonies"/></g:link></li>
                      <li class="icon-facility"><g:link controller="facilityProfile" action="index" params="[name:entity.name]"><g:message code="facilities"/></g:link></li>
                      <li class="icon-group"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]"><g:message code="groupClients"/></g:link></li>
                      <g:if test="${grailsApplication.config.project == 'sueninos'}">
                        <li class="icon-grouppartner"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]"><g:message code="groupPartners"/></g:link></li>
                      </g:if>
                    </ul>
                  </div>

                </div>
            </div>
          </div>
        </app:accessCheck>

        %{--<app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
          <div class="profile-box">
            <div class="second">
              --}%%{--Menue links Pädagogik--}%%{--
              <div class="header">
                <g:message code="privat.head.paedag"/> &nbsp;&nbsp;
                <a onclick="toggle('#paedag-toggled'); return false" href="#"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a>
              </div>

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
        </app:accessCheck>--}%

        <div class="profile-box">
          <div class="second">
            %{--Menue links Hilfe--}%
            <div class="header"><g:message code="privat.head.help"/></div>
            <ul>
              <li class="icon-help"><g:link controller="helper" id="${entity.id}"><g:message code="privat.showHelp"/></g:link></li>
            </ul>
          </div>
        </div>

      </div>
    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>
</div>
</body>
</html>