<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.projectName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset-fonts-grids.css')}" type="text/css">
  <g:set var="project" value="${grailsApplication.config.project}"/>
  %{--<link rel="stylesheet" href="${resource(dir: 'css', file:'common.css')}" type="text/css" media="screen" charset="utf-8">--}%
  <less:stylesheet name="common" />
  <less:stylesheet name="${project}/layout" />
  <less:scripts />
  %{--<link rel="stylesheet" href="${resource(dir: 'css/' + project, file:'layout.less')}" type="text/css" media="screen">--}%
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:layoutHead/>
  <g:javascript library="jquery" plugin="jquery"/>
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <g:javascript src="jquery/fullcalendar-1.4.10.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar-1.4.10.css')}"/>

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
      $(id).html('<img id="spinner" src="../images/spinner.gif" alt="Lade.."/>');
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
        for(elem in elements)
            document.getElementById(elem).value = "";
    };
  </script>

  <ga:trackPageviewAsynch /> 
</head>
<body>

<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>

<div id="private">
  <div id="doc4" class="yui-t7">

    <div id="hd">
      <g:render template="/templates/header"/>
      <g:render template="/templates/navigation"/>
    </div>

    <div style="background: #fff; padding-bottom: 10px">
      <g:render template="/templates/imagenav"/>
    </div>

    <div id="bd">
      <div id="yui-main">
        <div class="yui-b">
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
    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>
</div>

</body>
</html>