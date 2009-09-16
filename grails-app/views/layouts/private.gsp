<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Private Layout</title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
  </head>
  <body>
    <div id="doc4">
      <div id="hd">
        <-- Header Content -->
      </div>
      <div id="nav">
        <-- Navigation Content -->
      </div>
      <div id="banner">
        <-- Banner Content -->
      </div>

      <g:layoutBody />
      
      <div id="ft">
        <p>
          Future Wings © 2009 -
          <a href="#">Nutzungsbedingungen</a>
          -
          <a href="#">Datenschutzrichtlinien</a>
        </p>
      </div>
    </div>

  </body>
</head>
</html>