<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title>${grailsApplication.config.projectName} - <g:layoutTitle/></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <g:set var="project" value="${grailsApplication.config.project}"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file:'common.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="stylesheet" href="${resource(dir: 'css/' + project, file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${resource(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:javascript library="jquery" plugin="jquery"/>

    <script type="text/javascript">
      $(document).ready(function() {

        $('#flash-msg').delay(3000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

      });
    </script>

    <ga:trackPageviewAsynch /> 
  </head>
  <body>
    <div id="public">
      <div id="doc5" class="yui-t3">

        <div id="hd">
          <g:render template="/templates/header"/>
          <div id="nav">
            <g:render template="/templates/navigation" />
          </div>
        </div>

        <div id="banner"></div>

        <div id="bd">

          <div id="sidebar" class="yui-b">
            <app:isNotLoggedIn>
              <div class="sidebox">
                <div class="innersidebox">
                  <div class="sideboxheader">Login</div>
                  <div class="sideboxcontent">

                    <g:form controller="security" action="do_login" method="post">
                      <table>
                        <tr>
                          <td style="width: 100px; height: 20px">E-Mail:</td>
                          <td><g:textField name="userid" tabindex="1" /></td>
                        </tr>
                        <tr>
                          <td style="width: 100px; height: 20px">Passwort:</td>
                          <td><g:passwordField name="password" tabindex="2" /></td>
                        </tr>
                        <tr>
                          <td colspan="2" style="height: 25px"><g:checkBox name="remember_me" /> Angemeldet bleiben</td>
                        </tr>
                      </table>
    
                      <div class="login-form-button">
                        <g:submitButton name="submitButton" value="Anmelden" />
                      </div>

                      <div id="forgot-pwd"><g:link controller="app" action="password">Passwort vergessen?</g:link></div>

                    </g:form>
                    
                  </div>
                </div><!-- innersidebox -->
              </div><!-- sidebox -->
            </app:isNotLoggedIn>

            %{--<div class="sidebox">
              <div class="innersidebox">
                <div class="sideboxheader"><g:message code="sideboxheader.about"/></div>
                <div class="sideboxcontent">
                  <ul>
                    <li><g:link controller="static" action="zielsetzung" fragment="anker">Zielsetzung</g:link></li>
                    <li><g:link controller="static" action="ueberblick" fragment="anker">Überblick</g:link></li>
                    <li><g:link controller="static" action="teilleistungstraining" fragment="anker">Teilleistungstraining</g:link></li>
                    <li><g:link controller="static" action="lernen" fragment="anker">Lernen lernen</g:link></li>
                    <li><g:link controller="static" action="bewegung" fragment="anker">Bewegung - Ernährung</g:link></li>
                    <li><g:link controller="static" action="intelligenz" fragment="anker">Soziale & emotionale Intelligenz</g:link></li>
                    <li><g:link controller="static" action="kompetenz" fragment="anker">Persönliche Kompetenz</g:link></li>
                    <li><g:link controller="static" action="handwerk" fragment="anker">Handwerk und Kunst</g:link></li>
                    <li><g:link controller="static" action="impressum" fragment="anker">Impressum</g:link></li>
                    <li style="border-bottom: none"><g:link controller="static" action="futurewings" fragment="anker">Future Wings</g:link></li>
                  </ul>
                </div>
              </div><!-- innersidebox -->
            </div><!-- sidebox -->--}%

            <div class="sidebox">
              <div class="innersidebox">
                <div class="sideboxheader"><g:message code="sideboxheader.quote"/></div>
                <div class="sideboxcontent">
                  <app:getQuoteOfTheDay />
                </div>
              </div>
            </div>

            <div class="sidebox">
              <div class="innersidebox">
                <div class="sideboxheader"><g:message code="sideboxheader.picture"/></div>
                <div class="sideboxcontent" style="text-align: center">
                  <app:getPicOfTheDay>                    
                    <g:set var="day" value="${it}.png"/>
                    <img src='${resource(dir:"images/"+grailsApplication.config.project+"/static/daily_pic",file:day)}' width="235" height="180" alt="bild des tages" id="randomPicture"/>
                  </app:getPicOfTheDay>
                </div>
              </div>
            </div>

          </div><!-- yui-b -->

          <div id="yui-main">
            <div id="main" class="yui-b">
              <g:if test="${flash.message}">
                <div id="flash-msg">
                  ${flash.message}
                </div>
              </g:if>
              <g:layoutBody />
            </div>
          </div>

        </div><!-- bd -->

        <div id="ft">
          <g:render template="/templates/footer" />
        </div>

      </div><!-- doc4 -->
    </div><!-- public -->
  </body>
</html>
