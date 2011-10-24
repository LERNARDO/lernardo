<!DOCTYPE html>

<html>
  <head>
    <meta charset="utf-8" />
    <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
    <link rel="stylesheet" href="${resource (dir:'css', file:'reset-fonts-grids.css')}" type="text/css">
    <g:set var="customer" value="${grailsApplication.config.customer}"/>
    <less:stylesheet name="common" />
    <less:stylesheet name="${customer}" />
    <less:scripts />
    <link rel="icon" href="${resource(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:javascript library="jquery" plugin="jquery"/>
    <ckeditor:resources />

    <script type="text/javascript">
      $(document).ready(function() {
        $('#flash-msg').delay(3000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);
      });
    </script>

    <ga:trackPageview />
  </head>
  <body>
    <div id="public">
      <div id="doc5" class="yui-t3">

        <div id="hd">
          <g:render template="/templates/header"/>
        </div>

        <div id="banner"></div>

        <div id="bd">

          <div id="sidebar" class="yui-b">
            <erp:isNotLoggedIn>
              <div class="sidebox">
                <div class="innersidebox">
                  <div class="sideboxheader">Login</div>
                  <div class="sideboxcontent">

                    <g:form controller="security" action="do_login">
                      <table>
                        <tr>
                          <td style="width: 100px; height: 20px">E-Mail:</td>
                          <td><g:textField name="userid" tabindex="1"/></td>
                        </tr>
                        <tr>
                          <td style="width: 100px; height: 20px">Passwort:</td>
                          <td><g:passwordField name="password" tabindex="2"/></td>
                        </tr>
                        <tr>
                          <td colspan="2" style="height: 25px"><g:checkBox name="remember_me" /> Angemeldet bleiben</td>
                        </tr>
                      </table>
    
                      <div class="buttons">
                        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="Anmelden" /></div>
                        <div id="forgot-pwd"><g:link controller="app" action="password">Passwort vergessen?</g:link></div>
                      </div>
                    </g:form>
                    
                  </div>
                </div>
              </div>
            </erp:isNotLoggedIn>

            %{--<div class="sidebox">
              <div class="innersidebox">
                <div class="sideboxheader"><g:message code="sideboxheader.quote"/></div>
                <div class="sideboxcontent">
                  <erp:getQuoteOfTheDay />
                </div>
              </div>
            </div>

            <div class="sidebox">
              <div class="innersidebox">
                <div class="sideboxheader"><g:message code="sideboxheader.picture"/></div>
                <div class="sideboxcontent" style="text-align: center">
                  <erp:getPicOfTheDay>
                    <g:set var="day" value="${it}.png"/>
                    <img src='${resource(dir:"images/"+grailsApplication.config.customer+"/static/daily_pic",file:day)}' width="235" height="180" alt="picture of the day" id="randomPicture"/>
                  </erp:getPicOfTheDay>
                </div>
              </div>
            </div>--}%

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
