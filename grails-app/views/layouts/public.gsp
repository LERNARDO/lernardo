<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title><g:layoutTitle default="Lernardo" /></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${createLinkTo(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
  </head>
  <body>
    <div id="public">
      <div id="doc4" class="yui-t6">
        <div id="hd">
          <g:render template="/templates/header" />
        </div>
        <div id="nav">
          <g:render template="/templates/navigation" />
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
            <div class="sidebox">
              <div class="sideboxheader">Login</div>

              <div class="sideboxcontent">
                <form action='/j_spring_security_check' method='POST' name="login-form" id='loginForm'>
                  <table>
                    <tr>
                      <td width="100px">
                        <p>E-Mail:</p>
                      </td>
                      <td>
                        <input id="j_username" name="j_username" type="text" tabindex="1" />

                      </td>
                    </tr>
                    <tr>
                      <td>
                        <p>Passwort:</p>
                      </td>
                      <td>
                        <input name="j_password" id="j_password" type="password" tabindex="2" />

                      </td>
                    </tr>
                  </table>

                  <div class="login-form-button">
                    <input type="submit" name="submit" value="Anmelden" id="submit" />
                  </div>

                  <div id="forgot-pwd"><a href="#">Passwort vergessen?</a></div>

                </form>
              </div>
            </div><!-- sidebox -->
            <div class="sidebox">
              <div class="sideboxheader">Über Lernardo</div>
              <div class="sideboxcontent">
                <ul>
                  <li><g:link controller="static" action="zielsetzung" fragment="anker">Zielsetzung</g:link></li>
                  <li><g:link controller="static" action="ueberblick" fragment="anker">Überblick</g:link></li>
                  <li><g:link controller="static" action="teilleistungstraining" fragment="anker">Teilleistungstraining</g:link></li>
                  <li><g:link controller="static" action="lernen" fragment="anker">Lernen lernen</g:link></li>
                  <li><g:link controller="static" action="bewegung" fragment="anker">Bewegung - Ernährung</g:link></li>
                  <li><g:link controller="static" action="intelligenz" fragment="anker">Soziale und emotionale Intelligenz</g:link></li>
                  <li><g:link controller="static" action="kompetenz" fragment="anker">Persönliche Kompetenz</g:link></li>
                  <li><g:link controller="static" action="handwerk" fragment="anker">Handwerk und Kunst</g:link></li>
                  <!--<li><g:link controller="static" action="kontakt" fragment="anker">Kontakt</g:link></li>-->
                  <li><g:link controller="static" action="impressum" fragment="anker">Impressum</g:link></li>
                  <!--<li><g:link controller="static" action="loewenzahn" fragment="anker">Hort Löwenzahn</g:link></li>-->
                  <li style="border-bottom: none"><g:link controller="static" action="futurewings" fragment="anker">Future Wings</g:link></li>
                </ul>
              </div>
            </div><!-- sidebox -->
            <div class="sidebox">
              <div class="sideboxheader">Zitat des Tages</div>
              <div class="sideboxcontent"><span class="quote">„Die Aufgabe der Umgebung ist nicht
                  das Kind zu formen, sondern ihm zu
                  erlauben, sich zu offenbaren.“</span><br>
                von Maria Montessori</div>
            </div><!-- sidebox -->
            <div class="sidebox">
              <div class="sideboxheader">Bild des Tages</div>
              <div class="sideboxcontent"><img src="/lernardoV2/images/static/bild_des_tages.png" width="229" height="172" alt="bild des tages" id="randomPicture"/></div>
            </div><!-- sidebox -->
          </div>
        </div>
        <div id="ft">
          <g:render template="/templates/footer" />
        </div>
      </div><!-- doc4 -->
    </div><!-- public -->
  </body>
</html>