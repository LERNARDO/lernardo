<%@ page import="at.uenterprise.erp.PublicationType" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'publication')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'publication')]"/></h1>
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

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="title"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: publication, field: 'name', 'errors')} countable50" id="name" name="name" size="50" value="${fieldValue(bean:publication,field:'name').decodeHTML()}"/>
            </td>
          </tr>

        </table>

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
          <div class="clear"></div>
        </div>

      </g:form>
    </div>
  </div>
</body>