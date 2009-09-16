<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>Public Layout</title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
  </head>
  <body>
    <div id="public">
      <div id="doc4" class="yui-t5">
        <div id="hd">
          <div id="info">
            <p>Nicht angemeldet</p>
          </div>
          <div id="logo">
            <a href="${g.resource(dir:'')}">
              <img src="${resource(dir:'images', file:'leonardo-logo.png')}" width="270" height="70" alt="lernardo"/>
            </a>
          </div>
        </div>
        <div id="nav">
          <ul class="navigation" id="navigation_topmain">
            <li class="navigation_first"><a href="/">Home</a></li>
            <li><a href="/static/zielsetzung">Lernardo</a></li>
            <li><a href="/static/einrichtungen">Einrichtungen</a></li>
            <li><a href="/static/kontakt">Kontakt</a></li>
            <li class="navigation_last"><a href="/static/register">Registrieren</a></li>
          </ul>
        </div>
        <div id="banner">
          <img src="${resource(dir:'images', file:'banner.jpg')}" width="974" height="336" alt="lernardo"/>
        </div>
        <div id="bd">
          <div id="yui-main">
            <div id="main" class="yui-b">
              <g:layoutBody />
            </div>
          </div>
          <div id="sidebar" class="yui-b">
            <-- Sidebar Content -->
          </div>
        </div>
        <div id="ft">
          Future Wings © 2009 - <g:link controller="pages" action='usage'>Nutzungsbedingungen - Datenschutzrichtlinien</g:link>
        </div>
      </div>
    </div>
  </body>
</head>
</html>