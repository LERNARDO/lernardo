<head>
  <meta name="layout" content="private"/>
  <title>Dokumente</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Dokumente</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <app:isOperator entity="${entity}">
      <div class="action-buttons">
        <g:link class="buttonGreen" controller="publication" id="${entity.id}" action="create"><img src="${g.resource (dir:'images/icons', file:'icon_document.png')}" alt="icon" align="top"/> Neues Dokument anlegen</g:link>
        <div class="spacer" style="margin-bottom: 10px"></div>
      </div>
    </app:isOperator>
    <g:if test="${!pubtypes}">
    <div class="info-msg">
      Keine Dokumente vorhanden!
    </div>
    </g:if>

  <g:each in="${pubtypes}">
    <g:render template="pubtype" model="[entity:entity, type:it.key, publist:it.value]"/>
  </g:each>
    </div>

  </div>
  </body>
