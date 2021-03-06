<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="groupActivities"/></title>
</head>
<body>

<div class="boxHeader">
    <h1><g:message code="groupActivities"/></h1>
</div>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[totalGroupActivities, message(code: 'groupActivities')]"/>
    </div>

    <div class="buttons cleared">
      <g:form>
        <erp:accessCheck types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="choose" value="${message(code: 'groupActivity.plan')}"/></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div class="graypanel">

      <g:formRemote name="formRemote" url="[controller: 'groupActivityProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
            <td class="name"><g:message code="date"/></td>
            <td class="value">
              <span class="gray"><g:message code="from"/></span> <g:textField class="datepicker" name="beginDate" size="10" value=""/>
              <span class="gray"><g:message code="to"/></span> <g:textField class="datepicker" name="endDate" size="10" value=""/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="theme"/></td>
            <td class="value">
              <g:select name="theme" from="${themes}" optionKey="id" optionValue="${{it.profile.nameWithDate()}}" noSelection="['': message(code: 'non')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="labels"/></td>
            <td class="value">
              <g:select multiple="true" name="labels" from="${allLabels}" style="min-height: 115px;"/>
            </td>
          </tr>

        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
      </g:formRemote>

    </div>

    <div id="searchresults"></div>

</div>
</body>
