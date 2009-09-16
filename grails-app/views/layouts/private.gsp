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
        <g:render template="/templates/navigation" />
      </div>
      <div id="banner">
        <ol class="imgmenu">
          <li>
            <div id="comm" class="imgbox">
              <a href="#communications">
                <img src="/images/iconex/book_red.png" alt="">
                Ereignisse
              </a>
            </div>
          </li>

          <li>
            <div id="orga" class="imgbox">
              <a href="#organisation">
                <img src="/images/iconex/nut_and_bolt.png" alt="">
                Kalender
              </a>
            </div>
          </li>

          <li>
            <div id="member" class="imgbox">
              <a href="#member">
                <img src="/images/iconex/users_family.png" alt="">
                Profil
              </a>
            </div>
          </li>

          <li>
            <div id="paeds" class="imgbox">
              <a href="#pädagogic">
                <img src="/images/iconex/graduate.png" alt="" >
                Interventionsverwaltung
              </a>
            </div>
          </li>

          <li>
            <div id="admin" class="imgbox">
              <a href="#administration">
                <img src="/images/iconex/cabinet.png" alt="" >
                Admin
              </a>
            </div>
          </li>

        </ol>
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