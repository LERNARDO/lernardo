<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="groupActivityTemplates"/></title>
</head>
<body>

<div class="boxHeader">
    <h1><g:message code="groupActivityTemplates"/></h1>
</div>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[totalTemplates, message(code: 'groupActivityTemplates')]"/>
    </div>

    <div class="buttons cleared">
      <g:form>
        <erp:accessCheck types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupActivityTemplate')])}"/></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div class="graypanel">
      <g:formRemote name="formRemote" url="[controller: 'groupActivityTemplateProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
              <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> <span class="gray">(<g:message code="minutes"/>)</span>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="labels"/></td>
            <td class="value">
              <g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="age"/></td>
            <td class="value">
              <span class="gray"><g:message code="from"/></span> <g:textField name="ageFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField name="ageTo" size="5"/>
            </td>
          </tr>

        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
      </g:formRemote>
    </div>

    <div id="searchresults"></div>

</div>
</body>
