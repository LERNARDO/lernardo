<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'project')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'project')]"/></h1>
</div>
<div class="boxGray">

  <g:render template="/templates/errors" model="[bean: project]"/>

  <g:form id="${project.id}">

    <table>

      <tr class="prop">
        <td class="name"><g:message code="shiftTo"/></td>
        <td class="value">
          <g:select from="${-4..4}" name="weeks" value="1"/> <span class="gray"><g:message code="weeks"/></span>
        </td>
      </tr>

    </table>

    <div class="buttons cleared">
      <div class="button"><g:actionSubmit class="buttonGreen" action="shiftNow" value="${message(code: 'save')}" /></div>
      <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
    </div>

  </g:form>

</div>
</body>
