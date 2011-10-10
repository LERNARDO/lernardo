<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${customer}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <g:javascript src="jquery/fullcalendar.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">

  <script type="text/javascript">

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

    clearElements = function(elements) {
      for (x = 0; x <= elements.length; x++)
        $(elements[x]).val('');
    };

  </script>

  <ga:trackPageview />
  <g:layoutHead />

</head>
<body>

<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>

<div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
      <g:render template="/templates/navigation"/>
    </div>

    <div style="background: #fff;">
      <g:render template="/templates/imagenav"/>
    </div>

    <div class="yui3-g" id="grid-single">

      <g:if test="${flash.message}">
        <div id="flash-msg">
          ${flash.message}
        </div>
      </g:if>

      <div class="yui3-u" id="main">
        <div id="private-content">
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