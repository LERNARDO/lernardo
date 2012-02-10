<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="projectTemplates"/></title>
</head>
<body>

<div class="boxGreen">
  <div class="second">
    <h1><g:message code="projectTemplates"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalProjectTemplates, message(code: 'projectTemplates')]"/>
    </div>

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'projectTemplate')])}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">
      <g:formRemote name="formRemote0" url="[controller:'projectTemplateProfile', action:'updateselect']" update="searchresults" before="showspinner('#searchresults')">

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="value">
              <g:textField name="name" size="30"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="labels"/></td>
            <td valign="top" class="value">
              <g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="age"/></td>
            <td valign="top" class="value">
              <span class="gray"><g:message code="from"/></span> <g:textField name="ageFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField name="ageTo" size="5"/>
            </td>
          </tr>

        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
        <div class="spacer"></div>
      </g:formRemote>
    </div>

    <div id="searchresults"></div>

  </div>
</div>
</body>
