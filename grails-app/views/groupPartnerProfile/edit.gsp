<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'groupPartner')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'groupPartner')]"/></h1>
</div>
<div class="boxGray">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" required="" size="40" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea data-counter="50" class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="3" cols="50" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="groupPartner.profile.service"/></td>
          <td class="value">
            <g:select name="service" from="${Setup.list()[0]?.partnerServices}" value="${group?.profile?.service}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>