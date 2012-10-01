<head>
  <meta name="layout" content="start" />
  <title><g:message code="object.edit" args="[message(code: 'news')]"/></title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'news')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${news}">
      <div class="errors">
        <g:renderErrors bean="${news}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" id="${news.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="title"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: news, field: 'title', 'errors')}" name="title" size="50" value="${fieldValue(bean:news,field:'title').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="teaser"/></td>
          <td class="value">
            <g:textArea data-counter="500" class="${hasErrors(bean: news, field: 'teaser', 'errors')}" name="teaser" rows="3" cols="50" value="${fieldValue(bean:news,field:'teaser').decodeHTML()}"/>
            <span class="gray">(<g:message code="teaser.info"/>)</span><br/><br/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="content"/></td>
          <td class="value ${hasErrors(bean: news, field: 'content', 'errors')}">
            <ckeditor:editor name="content" height="300px" toolbar="Basic">
              ${fieldValue(bean:news,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}"/></div>
        <g:link class="buttonGray" controller="event" action="index"><g:message code="cancel"/></g:link>
      </div>

    </g:form>
  </div>
</div>
</body>