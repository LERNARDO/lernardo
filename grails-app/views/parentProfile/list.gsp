<head>
  <meta name="layout" content="database"/>
  <title><g:message code="parents"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="parents"/></h1>
</div>
<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalParents, message(code: 'parents')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'parent')])}"/></div>
        <div class="clear"></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'parentProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="active"/></td>
          <td valign="top" class="value">
            <g:checkBox name="active" value="true"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="gender"/></td>
          <td valign="top" class="value">
            <g:select name="gender" from="${['0':message(code:'all'),'1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupColony"/></td>
          <td valign="top" class="value">
            <g:select name="colony" from="${colonies}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.maritalStatus"/></td>
          <td valign="top" class="value">
            <g:select name="maritalStatus" from="${maritalStatus}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="parent.profile.education"/></td>
          <td valign="top" class="value">
            <g:select name="education" from="${schoolLevels}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="languages"/></td>
          <td valign="top" class="value">
            <g:select name="languages" multiple="true" from="${languages}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
      <div class="clear"></div>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>