<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityTemplates"/></title>
</head>

<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityTemplates"/></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'activityTemplate.create')}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div class="frame" style="border: 1px solid #aaa; padding: 5px; margin-bottom: 5px;">
      <p><g:message code="activityTemplate.list.hint2"/></p>
      <g:formRemote name="formRemote0" url="[controller:'templateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect')">

        <table>
          <tr>
            <td class="bold"><g:message code="name"/>:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td class="bold"><g:message code="duration"/>:</td>
            <td><g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
              <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
          </tr>
          <tr>
            <td class="bold"><g:message code="labels"/>:</td>
            <td><g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/></td>
          </tr>
          <tr>
            <td class="bold"><g:message code="age"/>:</td>
            <td><g:message code="from"/>: <g:textField name="ageFrom" size="5"/> <g:message code="to"/>: <g:textField name="ageTo" size="5"/></td>
          </tr>
          <tr>
            <td style="vertical-align: top" class="bold"><g:message code="vMethod"/> 1:</td>
            <td>
              <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
              <div id="elements1"></div>
            </td>
          </tr>
          <tr>
            <td style="vertical-align: top" class="bold"><g:message code="vMethod"/> 2:</td>
            <td>
              <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
              <div id="elements2"></div>
            </td>
          </tr>
          <tr>
            <td style="vertical-align: top" class="bold"><g:message code="vMethod"/> 3:</td>
            <td>
              <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
              <div id="elements3"></div>
            </td>
          </tr>
        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
        <div class="spacer"></div>
      </g:formRemote>
    </div>

    <div id="templateselect">
    </div>

  </div>
</div>
</body>