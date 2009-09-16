<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Private Layout</title>
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.8.0r4/build/reset-fonts-grids/reset-fonts-grids.css">
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.7.0/build/grids/grids-min.css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
  </head>
  <body>
    <div id="doc4" class="yui-t7">
      <div id="hd">
        <-- Header Content -->
      </div>
      <div id="nav">
        <-- Navigation Content -->
      </div>
      <div id="banner">
        <-- Banner Content -->
      </div>
      <div id="bd">
        <g:layoutBody />
      </div>
      <div id="ft">
        <-- Footer Content -->
      </div>
    </div>

  </body>
</head>
</html>