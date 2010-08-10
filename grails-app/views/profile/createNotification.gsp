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

        <g:hasErrors bean="${nc}">
          <div class="errors">
            <g:renderErrors bean="${nc}" as="list"/>
          </div>
        </g:hasErrors>

        <p>Bitte auswählen wer diese Nachricht bekommen soll (eine Auswahl mindestens erforderlich):</p>

        <g:form action="saveNotification" method="post">

          <p class="${hasErrors(bean:nc,field:'selection','errors')}">
            <g:checkBox name="user" value="${nc?.user}"/> User<br/>
            <g:checkBox name="operator" value="${nc?.operator}"/> Betreiber<br/>
            <g:checkBox name="client" value="${nc?.client}"/> Betreute<br/>
            <g:checkBox name="educator" value="${nc?.educator}"/> Pädagogen<br/>
            <g:checkBox name="parent" value="${nc?.parent}"/> Erziehungsberechtigte<br/>
            <g:checkBox name="child" value="${nc?.child}"/> Kinder<br/>
            <g:checkBox name="pate" value="${nc?.pate}"/> Paten<br/>
            <g:checkBox name="partner" value="${nc?.partner}"/> Partner<br/>
          </p>

          <table class="form">
            <tbody>

            <tr>
              <td>Titel:</td>
              <td class="value"><g:textField class="${hasErrors(bean:nc,field:'subject','errors')}" name="subject" size="60" value="${fieldValue(bean:nc,field:'subject')}"/></td>
            </tr>

            <tr>
              <td>Inhalt:</td>
              <td class="value ${hasErrors(bean:nc,field:'content','errors')}">
                <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
                <fckeditor:editor name="content" id="content" width="700" height="300" toolbar="Basic" fileBrowser="default">
                  ${nc?.content}
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
