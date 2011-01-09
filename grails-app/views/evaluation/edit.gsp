<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="evaluation.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="evaluation.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${evaluationInstance}">
      <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" id="${evaluationInstance.id}" params="[name:entity.name]">

      <p class="strong">Beschreibung</p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
        <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
          ${fieldValue(bean:evaluationInstance,field:'description').decodeHTML()}
        </ckeditor:editor>
      </span>

      <p class="strong">Maßnahme</p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
        <ckeditor:editor name="method" height="200px" width="800px" toolbar="Basic">
          ${fieldValue(bean:evaluationInstance,field:'method').decodeHTML()}
        </ckeditor:editor>
      </span>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonRed" action="del" id="${evaluationInstance.id}" params="[name:entity.name]" onclick="return confirm('${message(code:'delete.warn')}');">Löschen</g:link>
        <g:link class="buttonGray" action="list" id="${entity.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
