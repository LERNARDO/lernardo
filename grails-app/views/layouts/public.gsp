<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title><g:layoutTitle default="Lernardo" /></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
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
                <li><a href="/static/zielsetzung#anker">Zielsetzung</a></li>
                <li><a href="/static/ueberblick#anker">Überblick</a></li>
                <li><a href="/static/teilleistungstraining#anker">Teilleistungstraining</a></li>
                <li><a href="/static/lernen#anker">Lernen lernen</a></li>

                <li><a href="/static/bewegung#anker">Bewegung - Ernährung</a></li>
                <li><a href="/static/intelligenz#anker">Soziale und emotionale Intelligenz</a></li>
                <li><a href="/static/kompetenz#anker">Persönliche Kompetenz</a></li>
                <li><a href="/static/handwerk#anker">Handwerk und Kunst</a></li>
                <!--<li><a href="/static/kontakt#anker">Kontakt</a></li>-->
                <li><a href="/static/impressum#anker">Impressum</a></li>

                <!--<li><a href="/static/loewenzahn#anker">Hort Löwenzahn</a></li>-->
                <li style="border-bottom: none"><a href="/static/futurewings#anker">Future Wings</a></li>
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
              <div class="sideboxcontent"><img src="/images/bild_des_tages.png" width="229" height="172" alt="bild des tages" id="randomPicture"/></div>
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