<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <r:require modules="start"/>

  <r:script disposition="defer">
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

    // toggles the disabled attribute of an element
    toggleDisabled = function(id) {
      var status = $(id).attr('disabled');
      if (!status) {
        $(id).attr('disabled', 'disabled');
        $(id).val('');
      }
      else
        $(id).removeAttr('disabled');
    };

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

      $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

    });

    function showBigSpinner() {
      $('#loading').css('visibility', 'visible');
    }

  </r:script>

  <r:layoutResources/>
  <g:layoutHead />
  <ckeditor:resources />
  <ga:trackPageview />
</head>

<body>
  <div id="loading" style="position: absolute; left: 50%; text-align: center; top: 50%; visibility: hidden; z-index: 1000;">
  <img src="${resource(dir: 'images', file: 'big_spinner.gif')}" border=0></div>

  <g:if test="${!entity}">
    <g:set var="entity" value="${currentEntity}"/>
  </g:if>

  <div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
    </div>

    <div id="subheader">
      <ul>
        <li><g:link class="activegray" controller="event" action="index" onclick="showBigSpinner()"><g:message code="start"/></g:link></li>
        <li><g:link controller="educatorProfile" action="index" onclick="showBigSpinner()"><g:message code="database"/></g:link></li>
        <li><g:link controller="logBook" action="entries" onclick="showBigSpinner()"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index" onclick="showBigSpinner()"><g:message code="planning"/></g:link></li>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <li style="border-right: none;"><g:link controller="setup" action="show" onclick="showBigSpinner()"><g:message code="administration"/></g:link></li>
        </erp:accessCheck>
      </ul>
      <div class="clear"></div>
    </div>

    <div id="bd">
      <g:layoutBody/>
    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>

  <r:layoutResources/>
</body>
</html>
