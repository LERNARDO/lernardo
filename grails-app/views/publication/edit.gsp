<%@ page import="at.uenterprise.erp.PublicationType" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="publication.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="publication.profile.edit"/></h1>
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

      <g:form id="${publication.id}">

        <div class="text-field ${hasErrors(bean: publication, field: 'name', 'errors')}">
          <label for="name">Titel:</label><br />
          <g:textField id="name" name="name" size="70" value="${fieldValue(bean:publication,field:'name').decodeHTML()}"/>
        </div>

        %{--<div>
          <label for="category">Kategorie:</label><br />
          <g:select id="category" name="type.id" value="${publication?.type?.id}"
            from="${types}"
            optionKey="id"
            optionValue="name"
            noSelection="${['null':'Bitte auswählen...']}">
          </g:select>
        </div>--}%

        <div class="buttons">
          <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'change')}" /></div>
          <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
          <div class="spacer"></div>
        </div>

      </g:form>
    </div>
  </div>
</body>