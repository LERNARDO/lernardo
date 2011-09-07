<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplates"/></title>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="groupActivityTemplates"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityProfile" action="index"><g:message code="groupActivities"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'groupActivityTemplate.create')}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div style="margin-bottom: 5px;">
      <g:formRemote name="formRemote0" url="[controller:'groupActivityTemplateProfile', action:'updateselect2']" update="searchresults" before="showspinner('#searchresults')">

        <table>
          <tr>
            <td class="bold" style="padding-right: 10px;"><g:message code="name"/>:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td class="bold"><g:message code="duration"/>:</td>
            <td><g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
              <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> <span class="gray">(<g:message code="minutes"/>)</span></td>
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
