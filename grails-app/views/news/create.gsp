<head>
  <title><g:message code="object.create" args="[message(code: 'news')]"/></title>
  <meta name="layout" content="start"/>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'news')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

  <g:hasErrors bean="${news}">
    <div class="errors">
      <g:renderErrors bean="${news}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="save" id="${news.id}">

    <table>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="title"/></td>
        <td valign="top" class="value">
          <g:textField class="countable50 ${hasErrors(bean: news, field: 'title', 'errors')}" name="title" size="50" value="${fieldValue(bean:news,field:'title').decodeHTML()}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="teaser"/></td>
        <td valign="top" class="value">
          <g:textArea class="countable500 ${hasErrors(bean: news, field: 'teaser', 'errors')}" name="teaser" rows="3" cols="50" value="${fieldValue(bean:news,field:'teaser').decodeHTML()}"/>
          <span class="gray">(<g:message code="teaser.info"/>)</span><br/><br/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="content"/></td>
        <td valign="top" class="value ${hasErrors(bean: news, field: 'content', 'errors')}">
          <ckeditor:editor name="content" height="300px" toolbar="Basic">
            ${fieldValue(bean:news,field:'content').decodeHTML()}
          </ckeditor:editor>
        </td>
      </tr>

    </table>

    <div class="buttons">
      <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}" /></div>
      <g:link class="buttonGray" controller="event" action="index"><g:message code="cancel"/></g:link>
      <div class="clear"></div>
    </div>

  </g:form>
    </div>
  </div>
</body>