<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupClients"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="groupClients"/></h1>
</div>
<div class="boxContent">

  <div class="info-msg">
    <g:message code="object.total" args="[totalGroupClients, message(code: 'groupClients')]"/>
  </div>

  <erp:accessCheck types="['Betreiber', 'Pädagoge']">
    <div class="buttons cleared">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupClient')])}"/></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'groupClientProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <div style="margin-bottom: 10px;">
        <span class="gray"><g:message code="creator"/>:</span><br/>

        <g:remoteField size="40" name="remoteField1" update="remoteCreators" controller="profile" action="remoteCreators" before="showspinner('#remoteCreators')"/>
        <div id="remoteCreators"></div>

        <g:hiddenField name="creator" id="hiddenCreatorId" value=""/>
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

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>


</body>
