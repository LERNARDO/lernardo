<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projectTemplates"/></title>
</head>
<body>

<div class="boxGreen">
  <div class="second">
    <h1><g:message code="projectTemplates"/></h1>
  </div>
</div>

%{--<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectProfile" action="list"><g:message code="projects"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>--}%

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'projectTemplate')])}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div style="margin-bottom: 5px;">
      <g:formRemote name="formRemote0" url="[controller:'projectTemplateProfile', action:'updateselect']" update="searchresults" before="showspinner('#searchresults')">

        <table>
          <tr>
            <td class="bold" style="padding-right: 10px;"><g:message code="name"/>:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td class="bold" valign="top"><g:message code="labels"/>:</td>
            <td><g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/></td>
          </tr>
        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
        <div class="spacer"></div>
      </g:formRemote>
    </div>

    <div id="searchresults">
    </div>

  </div>
</div>
</body>
