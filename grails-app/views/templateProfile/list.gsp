<%@ page import="at.uenterprise.erp.base.Entity" %>
<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="activityTemplates"/></title>
</head>

<body>

<div class="boxHeader">
  <h1><g:message code="activityTemplates"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

  <div class="info-msg">
    <g:message code="object.total" args="[totalTemplates, message(code: 'activityTemplates')]"/>
  </div>

  <div class="buttons cleared">
      <erp:accessCheck types="['Pädagoge','Betreiber']">
          <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'activityTemplate')])}"/></div>
          </g:form>
      </erp:accessCheck>
  </div>

  <div class="graypanel">
    <g:formRemote name="formRemote" url="[controller: 'templateProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="creator"/></td>
          <td class="value">
              <g:remoteField size="40" name="remoteField1" update="remoteCreators" controller="profile" action="remoteCreators" before="showspinner('#remoteCreators')"/>
              <div id="remoteCreators"></div>
              <g:hiddenField name="creator" id="hiddenCreatorId" value=""/>
            <span id="creators2"><g:message code="none"/></span> <a href="" onclick="jQuery('#creators2').html('${message(code: 'none')}'); clearElements(['#hiddenCreatorId']); return false"><img src="${g.resource(dir:'images/icons', file:'cross.png')}" alt="Delete"/></a>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="duration"/></td>
          <td class="value">
            <g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'secondselect', update: 'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
            <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="labels"/></td>
          <td class="value">
            <g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/>
              <g:radioGroup name="labelLogic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="1">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="age"/></td>
          <td class="value">
            <span class="gray"><g:message code="from"/></span> <g:textField name="ageFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField name="ageTo" size="5"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 1</td>
          <td class="value">
            <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
              <g:radioGroup name="method1Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="1">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements1"></div>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 2</td>
          <td class="value">
            <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
              <g:radioGroup name="method2Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="1">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements2"></div>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 3</td>
          <td class="value">
            <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
              <g:radioGroup name="method3Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="1">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements3"></div>
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