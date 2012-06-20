<head>
  <meta name="layout" content="database"/>
  <title><g:message code="educators"/></title>
</head>
<body>

<div class="boxHeader">
  <h1><g:message code="educators"/></h1>
</div>

<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalEducators, message(code: 'educators')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'educator')])}"/></div>
        <div class="clear"></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">

    <g:formRemote name="formRemote" url="[controller: 'educatorProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
          <td valign="top" class="name"><g:message code="educator.profile.education"/></td>
          <td valign="top" class="value">
            <g:select name="education" multiple="true" from="${educations}" style="min-height: 115px;"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="educator.profile.employment"/></td>
          <td valign="top" class="value">
            <g:select name="employment" from="${employments}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="educator.profile.languages"/></td>
          <td valign="top" class="value">
            <g:select name="languages" multiple="true" from="${languages}" style="min-height: 115px;"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="country"/></td>
          <td valign="top" class="value">
            <g:select name="originCountry" from="${nationalities}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="facility"/></td>
          <td valign="top" class="value">
            <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'all')]"/>
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