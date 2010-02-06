<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Profil anlegen</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Profil anlegen</h2>

      <div id="select-box">
        <g:form name="form1" action="list">
          <label>Rolle
            <select name="profileType">
              <option value="lernardo" selected="selected">Lernardo-Mitarbeiter</option>
              <option value="paed">Pädagoge</option>
              <option value="client">Betreuter</option>
              <option value="einrichtung">Einrichtung</option>
              <option value="betreiber">Betreiber</option>
            </select>                  
          </label>
          <g:submitButton name="list" value="OK" />
        </g:form>
      </div>

      <g:form method="post" >
        <div class="dialog">
          <table>
            <tbody>

              <tr class="prop">
                <td valign="top" class="firstName">
                  <label for="firstName">
                    <g:message code="post.title.label" default="Vorname" />
                  </label>

                </td>
                <td valign="top">
                  <input type="text" id="firstName" name="firstName" value=""/>
                </td>
              </tr>

              <tr class="prop">
                <td valign="top" class="lastName">
                  <label for="lastName">
                    <g:message code="post.content.label" default="Nachname" />
                  </label>

                </td>
                <td valign="top">
                  <input type="text" id="lastName" name="lastName" value=""/>
                </td>
              </tr>

              <tr class="prop">
                <td valign="top" class="mail">
                  <label for="mail">
                    <g:message code="post.author.label" default="E-Mail" />
                  </label>

                </td>
                <td valign="top">
                  <input type="text" id="mail" name="mail" value=""/>
                </td>
              </tr>

              <tr class="prop">
                <td valign="top" class="password">
                  <label for="password">
                    <g:message code="post.author.label" default="Passwort" />
                  </label>

                </td>
                <td valign="top">
                  <input type="text" id="password" name="password" value=""/>
                </td>
              </tr>

            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button"><g:actionSubmit class="save" value="Update" /></span>
        </div>
      </g:form>

    </div>
  </body>
</html>