<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Lernardo</title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${createLinkTo(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:layoutHead />
  </head>
  <body>
    <div id="adminArea">
      <h1>LERNARDO Administrator-Verwaltung</h1>
      <div id="content">

        <g:if test="${flash.message}">
          <div id="flash-msg">
            ${flash.message}
          </div>
        </g:if>
        
        <g:layoutBody/>
      </div>
    </div>
  </body>
</html>