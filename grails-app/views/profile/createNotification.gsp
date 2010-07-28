<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Notifikation erstellen</title>
  </head>
  <body>
    <div class="headerGreen">
      <div class="second">
        <h1>Notifikation erstellen</h1>
      </div>
    </div>
    <div class="boxGray">
      <div class="second">

        <g:hasErrors bean="${msgInstance}">
          <div class="errors">
            <g:renderErrors bean="${msgInstance}" as="list"/>
          </div>
        </g:hasErrors>

        <p>Bitte auswählen wer diese Nachricht bekommen soll (eine Auswahl mindestens erforderlich):</p>

        <g:form action="saveNotification" method="post">

          <p>
            <g:checkBox name="user"/> User<br/>
            <g:checkBox name="operator"/> Betreiber<br/>
            <g:checkBox name="client"/> Betreute<br/>
            <g:checkBox name="educator"/> Pädagogen<br/>
            <g:checkBox name="parent"/> Erziehungsberechtigte<br/>
            <g:checkBox name="child"/> Kinder<br/>
            <g:checkBox name="pate"/> Paten<br/>
            <g:checkBox name="partner"/> Partner<br/>
          </p>

          <table class="form">
            <tbody>

            <tr>
              <td>Titel:</td>
              <td class="value ${hasErrors(bean:msgInstance,field:'subject','errors')}"><g:textField name="subject" size="60" value="${fieldValue(bean:msgInstance,field:'subject')}"/></td>
            </tr>

            <tr>
              <td>Inhalt:</td>
              <td class="value ${hasErrors(bean:msgInstance,field:'content','errors')}">
                <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
                <fckeditor:editor name="content" id="content" width="700" height="300" toolbar="Post" fileBrowser="default">
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
