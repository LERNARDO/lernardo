<head>
  <title><g:message code="object.create" args="[message(code: 'news')]"/></title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'news')]"/></h1>
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

    <p><span class="strong"><g:message code="title"/></span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'title', 'errors')}"><g:textField class="countable50" name="title" size="50" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></span></p>

    <p><span class="strong"><g:message code="article.teaser"/></span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'teaser', 'errors')}"><g:textArea class="countable500" name="teaser" rows="4" cols="10" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></span>
    <br/><span class="gray">(<g:message code="article.teaser.info"/>)</span></p>
    
    <span class="strong"><g:message code="content"/></span>
    <span class="${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <ckeditor:editor name="content" height="400px" toolbar="Basic">
        ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
      </ckeditor:editor>
    </span>
    
    <div class="buttons">
      <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}" /></div>
      <g:link class="buttonGray" action="index"><g:message code="cancel"/></g:link>
      <div class="spacer"></div>
    </div>

  </g:form>
    </div>
  </div>
</body>