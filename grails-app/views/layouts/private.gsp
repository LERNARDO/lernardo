<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.qtip.min.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'kolorpicker.css')}" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${customer}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <jqui:resources/>
  <ckeditor:resources />
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.periodicalupdater.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.qtip.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.kolorpicker.js')}" type="text/javascript"></script>

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

      $('input:text:visible:first').not('.datepicker, .datepicker-birthday, .search').focus();

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

      $(document).ready(function() {
        $('.tooltip').each(function() {
          $(this).qtip({
            content: {
              text: function(api) {
                 return $(this).attr('data-tooltip');
              }
            },
            position: {
              my: 'top left',  // Position my top left...
              at: 'right bottom', // at the bottom right of...
              target: $(this) // my target
            },
            style: {
              classes: 'ui-tooltip-blue'
            }
          });
        });
      });

      $('.timepicker').timepicker();

      $(".datepicker-birthday").datepicker({
        monthNamesShort: ['${message(code: "january.short")}',
                          '${message(code: "february.short")}',
                          '${message(code: "march.short")}',
                          '${message(code: "april.short")}',
                          '${message(code: "may.short")}',
                          '${message(code: "june.short")}',
                          '${message(code: "july.short")}',
                          '${message(code: "august.short")}',
                          '${message(code: "september.short")}',
                          '${message(code: "october.short")}',
                          '${message(code: "november.short")}',
                          '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
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
        monthNamesShort: ['${message(code: "january.short")}',
                          '${message(code: "february.short")}',
                          '${message(code: "march.short")}',
                          '${message(code: "april.short")}',
                          '${message(code: "may.short")}',
                          '${message(code: "june.short")}',
                          '${message(code: "july.short")}',
                          '${message(code: "august.short")}',
                          '${message(code: "september.short")}',
                          '${message(code: "october.short")}',
                          '${message(code: "november.short")}',
                          '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd. mm. yy',
        minDate: new Date(1900, 1, 1),
        firstDay: 1,
        autoSize: true});

      $('.datetimepicker').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}',
                     '${message(code: "february")}',
                     '${message(code: "march")}',
                     '${message(code: "april")}',
                     '${message(code: "may")}',
                     '${message(code: "june")}',
                     '${message(code: "july")}',
                     '${message(code: "august")}',
                     '${message(code: "september")}',
                     '${message(code: "october")}',
                     '${message(code: "november")}',
                     '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy'
      });

      $('.datetimepicker2').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}',
                     '${message(code: "february")}',
                     '${message(code: "march")}',
                     '${message(code: "april")}',
                     '${message(code: "may")}',
                     '${message(code: "june")}',
                     '${message(code: "july")}',
                     '${message(code: "august")}',
                     '${message(code: "september")}',
                     '${message(code: "october")}',
                     '${message(code: "november")}',
                     '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy,',
        timeFormat: 'hh:mm'
      });

      $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

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

    function showBigSpinner() {
      $('#loading').css('visibility', 'visible');
    }

    function hideBigSpinner() {
      $('#loading').css('visibility', 'hidden');
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
    </div>

    <div id="subheader">
      <ul>
        <li><g:link controller="event" action="indexNew" onclick="showBigSpinner()"><g:message code="start"/></g:link></li>
        <li><g:link controller="educatorProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="database"/></g:link></li>
        <li><g:link controller="logBook" action="entries" id="${entity.id}" onclick="showBigSpinner()"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index" onclick="showBigSpinner()"><g:message code="planning"/></g:link></li>
        <li style="border-right: none;"><g:link controller="setup" action="show" id="${entity.id}" params="[entity:entity.id]" onclick="showBigSpinner()"><g:message code="administration"/></g:link></li>
      </ul>
      <div class="clear"></div>
    </div>

    <div class="yui3-g" id="grid">

      <div class="yui3-u" id="left">
        <div class="boxHeader">
          <div class="second">
            <h1>${entity.profile.fullName} <g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img class="tooltip" data-tooltip="${message(code: 'isActive')}" src="${resource(dir: 'images/icons', file: 'icon_enabled.png')}" alt="aktiv" style="top: 1px; position: relative"/></g:if><g:else><img class="tooltip" data-tooltip="${message(code: 'isInactive')}" src="${resource(dir: 'images/icons', file: 'icon_disabled.png')}" alt="inaktiv"/></g:else></g:if></h1>
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

            <div class="header"></div>

            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <div class="area"><g:message code="privat.head.admin"/></div>
              <ul>
                %{--<erp:isSystemAdmin entity="${currentEntity}">
                  <li class="icon-admin"><g:link controller="admin" action="stuff">Admin Stuff</g:link></li>
                </erp:isSystemAdmin>--}%
                  <li class="icon-setup"><g:link controller="setup" action="show" id="${entity.id}" params="[entity:entity.id]">Setup</g:link></li>
                  <li class="profile-nachricht"><g:link controller="profile" action="createNotification"><g:message code="notifications"/></g:link></li>
                  %{--<li class="icon-export"><g:link controller="transfer" action="index" params="[name:entity.name]">Import/Export</g:link></li>--}%
                  <li class="icon-time"><g:link controller="educatorProfile" action="times" params="[name:entity.name]"><g:message code="timeEvaluation"/></g:link></li>
                  <li class="icon-evaluation"><g:link controller="evaluation" action="allevaluations" id="${entity.id}"><g:message code="evaluation.allevalentries"/></g:link></li>
                  <li class="profile-netzwerk"><g:link controller="comment" action="list" id="${entity.id}"><g:message code="allComments"/></g:link></li>
                  <li class="icon-all"><g:link controller="profile" action="list" params="[name:entity.name]"><g:message code="profile.all"/></g:link></li>
                  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
                    <li class="icon-admin"><g:link controller="userProfile" action="list" params="[name:entity.name]"><g:message code="user"/></g:link></li>
                  </erp:accessCheck>
              </ul>
            </erp:accessCheck>

            <div class="area"><g:message code="organisation"/></div>
            <ul>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
                <li class="icon-operator"><g:link controller="logBook" action="entries" id="${entity.id}"><g:message code="logBook"/></g:link></li>
              </erp:accessCheck>
            </ul>
            <div class="area"><g:message code="database"/></div>
            <ul>
              <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
                <li class="icon-operator"><g:link controller="operatorProfile" action="list" params="[name:entity.name]"><g:message code="operator"/></g:link></li>
              </erp:accessCheck>
              <li class="icon-educators"><g:link controller="educatorProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="educators"/></g:link></li>
              <li class="icon-person"><g:link controller="clientProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="clients"/></g:link></li>
              <li class="icon-child"><g:link controller="childProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="children"/></g:link></li>
              <li class="icon-parents"><g:link controller="parentProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="parents"/></g:link></li>
              <li class="icon-pate"><g:link controller="pateProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="paten"/></g:link></li>
              <li class="icon-partner"><g:link controller="partnerProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="partners"/></g:link></li>
              <li class="icon-group"><g:link controller="groupFamilyProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupFamilies"/></g:link></li>
              <li class="icon-colony"><g:link controller="groupColonyProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupColonies"/></g:link></li>
              <li class="icon-facility"><g:link controller="facilityProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="facilities"/></g:link></li>
              <li class="icon-group"><g:link controller="groupClientProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupClients"/></g:link></li>
              <li class="icon-grouppartner"><g:link controller="groupPartnerProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="groupPartners"/></g:link></li>
            </ul>
            <div class="area"><g:message code="planning"/></div>
            <ul>
              <li class="icon-admin"><g:link controller="templateProfile" action="index"><g:message code="activityTemplates"/></g:link></li>
              <li class="profile-template"><g:link controller="groupActivityTemplateProfile" action="list"><g:message code="groupActivityTemplates"/></g:link></li>
              <li class="profile-activities"><g:link controller="groupActivityProfile" action="list"><g:message code="groupActivities"/></g:link></li>
              <li class="profile-template"><g:link controller="projectTemplateProfile" action="list"><g:message code="projectTemplates"/></g:link></li>
              <li class="icon-admin"><g:link controller="projectProfile" action="list"><g:message code="projects"/></g:link></li>
              <li class="profile-activities"><g:link controller="activityProfile" action="list"><g:message code="imgmenu.activity.name"/></g:link></li>
              <li class="icon-admin"><g:link controller="themeProfile" action="list"><g:message code="themes"/></g:link></li>
            </ul>
            <div class="area"><g:message code="other"/></div>
            <ul>
              <li class="icon-news"><g:link controller="event" action="index" id="${entity.id}"><g:message code="events"/></g:link></li>
              <li class="icon-text"><g:link controller="news" action="index"><g:message code="newsp"/></g:link></li>
              <li class="icon-all"><g:link controller="overview" action="index" id="${currentEntity.id}"><g:message code="imgmenu.overview.name"/></g:link></li>
            </ul>

          </div>
        </div>

        <div class="profile-box">
          <div class="second">
            <div class="header"><g:message code="privat.head.online"/></div>
            <ul>
              <erp:getOnlineUsers>
                <g:each in="${onlineUsers}" var="entity">
                  <li class="icon-online"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></li>
                </g:each>
              </erp:getOnlineUsers>
            </ul>
          </div>
        </div>

        %{--<div id="livetickerbox"></div>--}%

      </div>

      <div class="yui3-u" id="main">
        <g:if test="${flash.message}">
          <div id="flash-msg">
            <img src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="success" style="top: 3px; position: relative"/> ${flash.message}
          </div>
        </g:if>
        <div style="padding: 0 15px;">
          <g:layoutBody/>
        </div>
      </div>

    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

</div>

</body>
</html>