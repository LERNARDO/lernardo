<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <title>Sueninos - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${g.resource(dir: 'css', file: 'yui-reset-fonts-grids.css')}" type="text/css">
  <g:set var="project" value="${grailsApplication.config.project}"/>
  <link rel="stylesheet" href="${resource(dir:'css/' + project,file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:layoutHead/>
  <g:javascript library="jquery" plugin="jquery"/>
  <script src="${g.resource(dir: 'js', file: 'lernardo.js')}" type="text/javascript"></script>
</head>
<body>
<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>
<div id="private">
  <div id="doc4" class="yui-t7">

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
    </div><!--bd-->

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>
  </div><!-- doc4 -->
</div><!-- private -->
</body>
</html>