<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} %{--${grailsApplication.config.customerName}--}% - <g:layoutTitle/></title>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <r:require modules="start"/>

  <r:script disposition="defer">
    %{--<g:render template="/templates/shortcuts"/>--}%

    $(document).ready(function() {

      $('.tooltip').each(function() {
        $(this).qtip({
          content: {
            text: function(api) {
               return $(this).attr('data-tooltip');
            }
          },
          position: {
            my: 'bottom left',
            at: 'top right',
            target: 'mouse' //$(this)
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
            my: 'bottom left',
            at: 'top right',
            target: 'mouse' //$(this)
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
          position: {
            my: 'bottom left',
            at: 'top right',
            target: 'mouse' //$(this)
          },
          show: {
            delay: 1000
          }
        });
      });

      $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

    });

  </r:script>

  <r:layoutResources/>

  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.kolorpicker.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'spin.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.simplemodal.js')}"></script>
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
        <li><g:link class="activegray" controller="event" action="index"><g:message code="start"/></g:link></li>
        <li><g:link controller="educatorProfile" action="index"><g:message code="database"/></g:link></li>
        <li><g:link controller="logBook" action="entries"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index"><g:message code="planning"/></g:link></li>
        <erp:accessCheck types="['Betreiber']">
          <li><g:link controller="setup" action="show"><g:message code="administration"/></g:link></li>
        </erp:accessCheck>
      </ul>
      <g:render template="/templates/search"/>
      <div class="clear"></div>
    </div>--}%

    <div id="bd" style="padding-top: 15px;">
      <g:layoutBody/>
    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>

  <r:layoutResources/>
</body>
</html>
