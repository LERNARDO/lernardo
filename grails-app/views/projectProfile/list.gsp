<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="projects"/></title>
</head>
<body>

<div class="boxGreen">
  <div class="second">
    <h1><g:message code="projects"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalProjects, message(code: 'projects')]"/>
    </div>

    <div class="graypanel">

      <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
            <td valign="top" class="name"><g:message code="creator"/></td>
            <td valign="top" class="value">
              <span id="creators2"><g:message code="none"/></span> <a href="" onclick="jQuery('#creators2').html('${message(code: 'none')}'); clearElements(['#hiddentextfield1']); return false"><img src="${g.resource(dir:'images/icons', file:'cross.png')}" alt="Delete"/></a>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="value">
              <g:textField name="name" size="30"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="date"/></td>
            <td valign="top" class="value">
              <span class="gray"><g:message code="from"/></span> <g:textField class="datepicker" name="beginDate" size="10" value=""/>
              <span class="gray"><g:message code="to"/></span> <g:textField class="datepicker" name="endDate" size="10" value=""/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="theme"/></td>
            <td valign="top" class="value">
              <g:select name="theme" from="${themes}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'non')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="labels"/></td>
            <td valign="top" class="value">
              <g:select multiple="true" name="labels" from="${allLabels}" style="min-height: 115px;"/>
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
