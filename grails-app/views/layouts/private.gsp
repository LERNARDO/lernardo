<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.projectName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.qtip.min.css')}" type="text/css">
  <g:set var="project" value="${grailsApplication.config.project}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${project}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <jqui:resources/>
  <ckeditor:resources />
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon-0.6.2.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.periodicalupdater.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.qtip.min.js')}" type="text/javascript"></script>

  <script type="text/javascript">
    // TODO: the following custom JavaScript functions have to be defined here else Chrome 10 and IE 9 are not able to find them, find out why..
    // hides an element
    hideform = function(id) {
      $(id).hide('slow');
    };

    // shows an element
    showform = function(id) {
      $(id).show('slow');
    };

    // clears the text of an element
    cleartext = function(){
      document.getElementById('hide').value='';
    };

    // shows the spinner
    showspinner = function(id) {
      $(id).html('<img id="spinner" src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Lade.."/>');
    };

    // toggle element
    toggle = function(id) {
      $(id).toggle(400);
    };

    // fadetoggle element
    ftoggle = function(id) {
      $(id).fadeToggle(400);
    };

    // clears the value of multiple elements
    clearElements = function(elements) {
      for (x = 0; x <= elements.length; x++)
        $(elements[x]).val('');
    };

    $(document).ready(function() {

      $('input:text:visible:first').not('.datepicker, .datepicker-birthday').focus();

      // disabled for next release
      /*$.PeriodicalUpdater('${grailsApplication.config.grails.serverURL}/app/liveticker', { // not working in DEV environment
        method: 'get',          // method; get or post
        data: '',               // array of values to be passed to the page - e.g. {name: "John", greeting: "hello"}
        minTimeout: 60000,      // starting value for the timeout in milliseconds
        maxTimeout: 5000,       // maximum length of time between requests
        multiplier: 1,          // if set to 2, timerInterval will double each time the response hasn't changed (up to maxTimeout)
        type: 'text',           // response type - text, xml, json, etc.  See $.ajax config options
        maxCalls: 0,            // maximum number of calls. 0 = no limit.
        autoStop: 0             // automatically stop requests after this many returns of the same data. 0 = disabled.
      },
      function(data){
        $('#livetickerbox').empty().append(data);
      });*/

      // should display the image of an entity when hovering link - not working
      /*$('.hoverImage').qtip({
         content: {
            text: 'Loading...', // The text to use whilst the AJAX request is loading
            ajax: {
               url: '/lernardo/app/showImage',
               type: 'GET', // POST or GET
               data: {name: $(this).find('div').attr('id')},
              once: false
            }
         }
        style: {
          classes: 'ui-tooltip-blue'
        }
      });*/

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
        firstDay: 1,
        autoSize: true});

      $('.datetimepicker').datetimepicker({
        dateFormat: 'dd. mm. yy'
      });

      $('.datetimepicker2').datetimepicker({
        dateFormat: 'dd. mm. yy,',
        timeFormat: 'hh:mm'
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

      $('.countable5000').jqEasyCounter({
        'maxChars': 5000,
        'maxCharsWarning': 5000
      });

    });

    function changeTab (aktiv_tab, aktiv_inhalt, passiv_tab, passiv_inhalt) {
        document.getElementById(aktiv_tab).className = "aktiv_tab";
        document.getElementById(aktiv_inhalt).className = "aktiv_inhalt";
        document.getElementById(passiv_tab).className = "passiv_tab";
        document.getElementById(passiv_inhalt).className = "passiv_inhalt";
    }

    function showBigSpinner() {
      $('#loading').css('visibility', 'visible');
    }
  </script>

  <ga:trackPageview />
  <g:layoutHead />

</head>
<body>

<div id="loading" style="position:absolute; left: 50%; text-align:center; top:50%; visibility: hidden;">
<img src="${resource(dir: 'images', file: 'big_spinner.gif')}" border=0></div>

<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>

%{--<div id="erp"><div class="title">ERP</div></div>--}%

<div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
      <g:render template="/templates/navigation"/>
    </div>

    <div style="background: #fff;">
      <g:render template="/templates/imagenav"/>
    </div>

    %{--<div id="bd">--}%
    <div class="yui3-g" id="grid">

      <div class="yui3-u" id="profile-navigation">
        <div class="boxHeader">
          <div class="second">
            <h1>${entity.profile.fullName} <g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource(dir: 'images/icons', file: 'icon_enabled.png')}" alt="aktiv" style="top: 3px; position: relative"/></g:if><g:else><img src="${resource(dir: 'images/icons', file: 'icon_disabled.png')}" alt="inaktiv"/></g:else></g:if></h1>
          </div>
        </div>

        <div class="profile-box" style="border-top-left-radius: 0; border-top-right-radius: 0">
          <div class="second">

            <g:if test="${entity.type.supertype.name == 'user' || entity.type.supertype.name == 'child' || entity.type.supertype.name == 'client' || entity.type.supertype.name == 'educator' || entity.type.supertype.name == 'parent' || entity.type.supertype.name == 'partner' || entity.type.supertype.name == 'pate' || entity.type.supertype.name == 'operator' || entity.type.supertype.name == 'facility' || entity.type.supertype.name == 'groupActivity' || entity.type.supertype.name == 'project'}">
              <g:render template="/templates/${entity.type.supertype.name +'Navigation'}" model="[entity: entity]"/>
            </g:if>
            <g:else>
              <g:render template="/templates/defaultNavigation" model="[entity: entity]"/>
            </g:else>

          </div>
        </div>

        <div class="profile-box">
          <div class="second">

            %{-- Administration/Verwaltung --}%
            <div class="header">

              <label id="tab-verwaltung" class="aktiv_tab" onclick="changeTab('tab-verwaltung', 'inhalt-verwaltung', 'tab-admin', 'inhalt-admin')"><g:message code="privat.head.verw"/></label>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                 <span class="gray">|</span> <label id="tab-admin" class="passiv_tab" onclick="changeTab('tab-admin', 'inhalt-admin', 'tab-verwaltung', 'inhalt-verwaltung')"><g:message code="privat.head.admin"/></label>
              </erp:accessCheck>

              &nbsp;%{--<a onclick="toggle('#administration-toggled'); return false" href="#"><img alt="ein-/ausblenden" src="${resource(dir: 'images/icons', file: 'icon_add.png')}"></a>--}%</div>
              <div id="administration-toggled">

                <div id="inhalt-admin" class="passiv_inhalt">
                  <ul>
                    <erp:isSystemAdmin entity="${currentEntity}">
                      <li class="icon-admin"><g:link controller="app" action="adminlinks">Admin Stuff</g:link></li>
                    </erp:isSystemAdmin>
                    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                      <li class="profile-nachricht"><g:link controller="profile" action="createNotification"><g:message code="notifications"/></g:link></li>
                      <li class="icon-methods"><g:link controller="method" action="index" params="[name:entity.name]"><g:message code="vMethods"/></g:link></li>
                      <li class="icon-methods"><g:link controller="label" action="index" params="[name:entity.name]"><g:message code="labels"/></g:link></li>
                      %{--<li class="icon-export"><g:link controller="transfer" action="index" params="[name:entity.name]">Import/Export</g:link></li>--}%
                      <li class="icon-time"><g:link controller="educatorProfile" action="times" params="[name:entity.name]"><g:message code="timeEvaluation"/></g:link></li>
                      <li class="icon-time"><g:link controller="workdayCategory" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.workdaycategories"/></g:link></li>
                      <li class="icon-time"><g:link controller="educatorProfile" action="workhours" id="${entity.id}" params="[entity:entity.id]"><g:message code="educator.profile.workHours"/></g:link></li>
                      <li class="icon-admin"><g:link controller="setup" action="show" id="${entity.id}" params="[entity:entity.id]">ERP Setup</g:link></li>
                      <li class="icon-admin"><g:link controller="evaluation" action="listall" id="${entity.id}"><g:message code="evaluation.allentry"/></g:link></li>
                      <li class="icon-admin"><g:link controller="comment" action="list" id="${entity.id}">Alle Kommentare</g:link></li>
                    </erp:accessCheck>
                  </ul>
                </div>

                <div id="inhalt-verwaltung" class="aktiv_inhalt">
                  <ul>
                    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                      <li class="icon-all"><g:link controller="profile" action="list" params="[name:entity.name]"><g:message code="profiles"/></g:link></li>
                    </erp:accessCheck>
                    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
                      <li class="icon-operator"><g:link controller="operatorProfile" action="list" params="[name:entity.name]"><g:message code="operator"/></g:link></li>
                      <li class="icon-admin"><g:link controller="userProfile" action="list" params="[name:entity.name]"><g:message code="user"/></g:link></li>
                      <hr/>
                    </erp:accessCheck>
                    <li class="icon-educators"><g:link controller="educatorProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="educators"/></g:link></li>
                    <li class="icon-person"><g:link controller="clientProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="clients"/></g:link></li>
                    <g:if test="${grailsApplication.config.project == 'sueninos'}">
                      <li class="icon-child"><g:link controller="childProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="children"/></g:link></li>
                    </g:if>
                    <li class="icon-parents"><g:link controller="parentProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="parents"/></g:link></li>
                    <g:if test="${grailsApplication.config.project == 'sueninos'}">
                      <li class="icon-pate"><g:link controller="pateProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="paten"/></g:link></li>
                    </g:if>
                    <li class="icon-partner"><g:link controller="partnerProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="partners"/></g:link></li>
                    <hr/>
                    <li class="icon-group"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupFamilies"/></g:link></li>
                    <li class="icon-colony"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupColonies"/></g:link></li>
                    <li class="icon-facility"><g:link controller="facilityProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="facilities"/></g:link></li>
                    <li class="icon-group"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupClients"/></g:link></li>
                    <g:if test="${grailsApplication.config.project == 'sueninos'}">
                      <li class="icon-grouppartner"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupPartners"/></g:link></li>
                    </g:if>
                  </ul>
                </div>

              </div>
          </div>
        </div>

        %{--<div id="livetickerbox"></div>--}%

        <div class="profile-box">
          <div class="second">
            <div class="header"><g:message code="privat.head.online"/></div>
            <ul id="onlineUsers">
              <erp:getOnlineUsers>
                <g:each in="${onlineUsers}" var="entity">
                  <li><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></li>
                </g:each>
              </erp:getOnlineUsers>
            </ul>
          </div>
        </div>

        %{--<div class="profile-box">
          <div class="second">
            <div class="header"><g:message code="privat.head.online"/></div>
            <ul id="onlineUsers">
              <erp:getOnlineUsers>
                <g:each in="${onlineUsers}" var="entity">
                  <li><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></li>
                </g:each>
              </erp:getOnlineUsers>
            </ul>
          </div>
        </div>--}%

      </div>

      <div class="yui3-u" id="main">
        <g:if test="${flash.message}">
          <div id="flash-msg">
            <img src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="success" style="top: 3px; position: relative"/> ${flash.message}
          </div>
        </g:if>
        <div id="private-content">
          <g:layoutBody/>
        </div>
      </div>

      %{--<div class="yui3-u" id="extra">
      </div>--}%

    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

</div>

</body>
</html>