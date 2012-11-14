<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <r:require modules="other"/>

  <r:script disposition='defer'>
    %{--<g:render template="/templates/shortcuts"/>--}%

    $(document).ready(function() {

      $('input:text:visible:first').not('.datepicker, .datepicker-birthday, .search').focus();

      $('.tooltip').each(function() {
        $(this).qtip({
          content: {
            text: function(api) {
               return $(this).attr('data-tooltip');
            }
          },
          position: {
            viewport: $(window),
            my: 'top left',  // Position my top left...
            at: 'right bottom', // at the bottom right of...
            target: $(this) // my target
          },
          style: {
            classes: 'ui-tooltip-blue'
          }
        });
      });

      $('.tooltiphelp').each(function() {
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
            classes: 'ui-tooltip-green'
          }
        });
      });

      $('.largetooltip').each(function() {
        $(this).qtip({
          content: {
            text: 'Loading...',
            ajax: {
              url: '${grailsApplication.config.grails.serverURL}/profile/getTooltip',
              type: 'GET',
              data: {id : $(this).attr('data-idd')}
            }
          },
          show: {
            delay: 1000
          }
        });
      });

      $('.timepick').timepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        timeOnlyTitle: '${message(code: "chooseTime")}',
        stepMinute: 5
      });

      $(".datepicker-birthday").datepicker({
        monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
                          '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
                          '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
                          '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
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
        monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
                          '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
                          '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
                          '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
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
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
                     '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
                     '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
                     '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy',
        stepMinute: 5
      });

      $('.datetimepicker2').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
                     '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
                     '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
                     '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy,',
        timeFormat: 'hh:mm',
        stepMinute: 5
      });

      $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

      $('[data-counter]').jqEasyCounter();

    });

  </r:script>

  <r:layoutResources/>

  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.kolorpicker.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.simplemodal.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'spin.min.js')}"></script>
  %{--<script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.hotkeys-0.7.9.min.js')}"></script>--}%

  <g:layoutHead />
  <ckeditor:resources />
  <ga:trackPageview />

</head>

<body>

  <div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
    </div>

      <g:render template="/templates/subheader"/>
    %{--<div id="subheader">
      <ul>
        <li><g:link controller="event" action="index"><g:message code="start"/></g:link></li>
        <li><g:link class="activered" controller="educatorProfile" action="index"><g:message code="database"/></g:link></li>
        <li><g:link controller="logBook" action="entries"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index"><g:message code="planning"/></g:link></li>
        <erp:accessCheck types="['Betreiber']">
          <li><g:link controller="setup" action="show"><g:message code="administration"/></g:link></li>
        </erp:accessCheck>
      </ul>
      <g:render template="/templates/search"/>
      <div class="clear"></div>
    </div>--}%

    <div class="yui3-g" id="grid">

      %{--<div class="yui3-u" id="left">

        <div class="profile-box">

            <div class="header"><g:message code="database"/></div>

            <ul>
              <erp:accessCheck roles="['ROLE_ADMIN']">
                <li class="icon-operator"><g:link controller="operatorProfile" action="list"><g:message code="operator"/></g:link></li>
              </erp:accessCheck>
              <li class="icon-educators"><g:link controller="educatorProfile" action="list"><g:message code="educators"/></g:link></li>
              <li class="icon-person"><g:link controller="clientProfile" action="list"><g:message code="clients"/></g:link></li>
              <li class="icon-child"><g:link controller="childProfile" action="list"><g:message code="children"/></g:link></li>
              <li class="icon-parents"><g:link controller="parentProfile" action="list"><g:message code="parents"/></g:link></li>
              <li class="icon-pate"><g:link controller="pateProfile" action="list"><g:message code="paten"/></g:link></li>
              <li class="icon-partner"><g:link controller="partnerProfile" action="list"><g:message code="partners"/></g:link></li>
              <li class="icon-group"><g:link controller="groupFamilyProfile" action="list"><g:message code="groupFamilies"/></g:link></li>
              <li class="icon-colony"><g:link controller="groupColonyProfile" action="list"><g:message code="groupColonies"/></g:link></li>
              <li class="icon-facility"><g:link controller="facilityProfile" action="list"><g:message code="facilities"/></g:link></li>
              <li class="icon-group"><g:link controller="groupClientProfile" action="list"><g:message code="groupClients"/></g:link></li>
              <li class="icon-grouppartner"><g:link controller="groupPartnerProfile" action="list"><g:message code="groupPartners"/></g:link></li>
              <erp:accessCheck roles="['ROLE_ADMIN']">
                <li class="icon-admin"><g:link controller="userProfile" action="list"><g:message code="user"/></g:link></li>
              </erp:accessCheck>
            </ul>

        </div>

        <div class="profile-box">
            <div class="header"><g:message code="privat.head.online"/></div>
            <ul id="onlineusers">
              <g:render template="/templates/onlineUsers"/>
            </ul>
        </div>

      </div>--}%

      <div class="yui3-u" id="main">
        <g:if test="${flash.message}">
          <div id="flash-msg">
            <img src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="success" style="top: 3px; position: relative"/> ${flash.message}
          </div>
        </g:if>
        <div id="bd">
          <g:layoutBody/>
        </div>
      </div>

    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>

  <r:layoutResources/>
</body>
</html>