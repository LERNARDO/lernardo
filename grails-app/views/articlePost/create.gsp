<head>
  <title>Artikel erstellen</title>
  <meta name="layout" content="public"/>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1>Artikel erstellen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

  <g:hasErrors bean="${postInstance}">
    <div class="errors">
      <g:renderErrors bean="${postInstance}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="save" id="${postInstance.id}">

    <p><span class="strong">Titel</span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'title', 'errors')}"><g:textField class="countable50" name="title" style="width: 100%" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></span></p>

    <p><span class="strong">Teaser</span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'teaser', 'errors')}"><g:textArea class="countable500" name="teaser" rows="4" cols="10" style="width: 100%" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></span>
    <br/><span class="gray">(der Teaser ist optional und muss nicht ausgefüllt werden)</span></p>
    
    <span class="strong">Inhalt</span>
    <span class="${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <ckeditor:editor name="content" height="400px" width="700px" toolbar="Basic">
        ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
      </ckeditor:editor>
    </span>
    
    <div class="buttons">
      <g:submitButton name="submitButton" value="${message(code:'save')}" />
      <g:link class="buttonGray" action="index"><g:message code="cancel"/></g:link>
      <div class="spacer"></div>
    </div>

  </g:form>
    </div>
  </div>
</body>