<head>
  <title><g:message code="article.edit"/></title>
  <meta name="layout" content="public" />
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="article.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

  <g:hasErrors bean="${postInstance}">
    <div class="errors">
      <g:renderErrors bean="${postInstance}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="update" id="${postInstance.id}">
    <div>

    <p><span class="strong"><g:message code="article.title"/></span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'title', 'errors')}"><g:textField class="countable${postInstance.constraints.title.maxSize}" name="title" style="width: 100%" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></span></p>

    <p><span class="strong"><g:message code="article.teaser"/></span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'teaser', 'errors')}"><g:textArea class="countable${postInstance.constraints.teaser.maxSize}" name="teaser" rows="4" cols="10" style="width: 100%" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></span>
    <br/><span class="gray">(<g:message code="article.teaser.info"/>)</span></p>
    
    <span class="strong">Inhalt</span>
    <span class="${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <ckeditor:editor name="content" height="400px" width="700px" toolbar="Basic">
        ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
      </ckeditor:editor>
    </span>

    <div class="buttons">
      <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}"/></div>
      <g:link class="buttonGray" action="index"><g:message code="cancel"/></g:link>
      <div class="spacer"></div>
    </div>

    </div>
  </g:form>
    </div>
  </div>
</body>