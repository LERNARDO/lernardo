<%@ page import="lernardo.PublicationType" %>
<head>
  <meta name="layout" content="private"/>
  <title>Dokument anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Dokument anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>

      <g:hasErrors bean="${publication}">
        <div id="flash-msg">
          <div class="errors">
            <g:renderErrors bean="${publication}" as="list"/>
          </div>
        </div>
      </g:hasErrors>

      <g:uploadForm action="save" id="${entity.id}">

        <div class="text-field ${hasErrors(bean: publication, field: 'name', 'errors')}">
          <label for="name">Titel:</label><br />
          <g:textField id="name" name="name" size="60" value="${fieldValue(bean:publication,field:'name')}"/>
        </div>

        %{--TODO: figure out how to make this box red on validation error--}%
        <div>
          <label for="category">Kategorie:</label><br />
          <g:select id="category" name="type.id" value="${publication?.type?.id}"
            from="${PublicationType.list()}"
            optionKey="id"
            optionValue="name"
            noSelection="${['null':'Kategorie auswählen...']}">
          </g:select>
        </div>

        %{-- TODO: uncomment when implemented

        <div>
          <br/>
          <label for="category">Freigabe:</label><br />
          <g:select name="accesslevel"
            from="${[0:'Alle',1:'Netzwerk & Freunde',2:'nur Freunde',3:'Privat']}"
            optionKey="key"
            optionValue="value"
            noSelection="${['null':'Freigabe auswählen...']}">
          </g:select>
        </div>--}%

        %{--TODO: figure out how to make this box red on validation error--}%
        <div class="file-field">
          <label for="file">Datei auswählen:</label><br />
          <input size="50" id="file" type="file" name="file"/>
        </div>

        <div class="bottom-buttons">
          <g:submitButton name="update" value="Hinzufügen"/>
          <g:link class="buttonGray" controller="publication" action="profile" id="${entity.id}">Abbrechen</g:link>
          <div class="spacer"></div>
        </div>

      </g:uploadForm>
    </div>
  </div>
</body>
