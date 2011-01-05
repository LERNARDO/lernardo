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
  <script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>
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