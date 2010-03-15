<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Notifikation erstellen</title>
  </head>
  <body>
    <div class="headerBlue">
      <div class="second">
        <h1>Notifikation erstellen</h1>
      </div>
    </div>
    <div class="boxGray">
      <div class="second">
        
        <p style="color: #f00">Achtung! Diese Notifikation wird als persönliche Nachricht an jeden User geschickt!</p>
        <g:hasErrors bean="${msgInstance}">
          <div class="errors">
            <g:renderErrors bean="${msgInstance}" as="list"/>
          </div>
        </g:hasErrors>

        <g:form action="saveNotification" method="post">
          <table class="form">
            <tbody>

            <tr>
              <td>Titel:</td>
              <td class="value ${hasErrors(bean:msgInstance,field:'subject','errors')}"><g:textField name="subject" size="40" value="${fieldValue(bean:msgInstance,field:'subject')}"/></td>
            </tr>

            <tr>
              <td>Inhalt:</td>
              <td class="value ${hasErrors(bean:msgInstance,field:'content','errors')}">
                <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js').toString()}"/>
                <fckeditor:editor name="content" id="content" width="530" height="400" toolbar="Post" fileBrowser="default">
                  ${msgInstance.content}
                </fckeditor:editor>
              </td>
            </tr>

            </tbody>
          </table>
          <div class="buttons">
            <g:submitButton name="saveNotification" value="Erstellen"/>
            <g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">Abbrechen</g:link>
            <div class="spacer"></div>
          </div>
        </g:form>

      </div>
    </div>
  </body>
</html>
