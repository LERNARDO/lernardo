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

    <div class="buttons cleared">
        <erp:accessCheck types="['Pädagoge','Betreiber']">
            <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'projectTemplate')])}"/></div>
            </g:form>
        </erp:accessCheck>
    </div>

    <div class="graypanel">
      <g:formRemote name="formRemote" url="[controller: 'projectTemplateProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

        <div style="margin-bottom: 10px;">
          <span class="gray"><g:message code="creator"/>:</span><br/>

          <g:remoteField size="40" name="remoteField1" update="remoteCreators" controller="profile" action="remoteCreators" before="showspinner('#remoteCreators')"/>
          <div id="remoteCreators"></div>

          <div style="visibility: hidden">
            <g:textField name="creator" id="hiddentextfield1" value=""/>
          </div>
        </div>

        <table>

          <tr class="prop">
            <td class="name"><g:message code="creator"/></td>
            <td class="value">
              <span id="creators2"><g:message code="none"/></span> <a href="" onclick="jQuery('#creators2').html('${message(code: 'none')}'); clearElements(['#hiddentextfield1']); return false"><img src="${g.resource(dir:'images/icons', file:'cross.png')}" alt="Delete"/></a>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="name"/></td>
            <td class="value">
              <g:textField name="name" size="30"/>
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
        <div class="clear"></div>
      </g:formRemote>
    </div>

    <div id="searchresults"></div>

  </div>
</div>
</body>
