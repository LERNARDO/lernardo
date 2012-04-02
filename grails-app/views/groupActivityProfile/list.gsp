<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="groupActivities"/></title>
</head>
<body>

<div class="boxGreen">
  <div class="second">
    <h1><g:message code="groupActivities"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalGroupActivities, message(code: 'groupActivities')]"/>
    </div>

    <div class="buttons">
      <g:form>
        <erp:accessCheck types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="choose" value="${message(code: 'groupActivity.plan')}"/></div>
          <div class="clear"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">

      <g:formRemote name="formRemote0" url="[controller:'groupActivityProfile', action:'updateselect']" update="searchresults" before="showspinner('#searchresults')">

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

          %{--<tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="value">
              <g:remoteField size="30" name="instantSearch" update="searchresults" paramName="name" url="[action:'searchbyname']" before="showspinner('#searchresults')" />
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name"><g:message code="date"/></td>
            <td valign="top" class="value">
              %{--<g:formRemote name="formRemote" url="[action: 'searchbydate']" update="searchresults">--}%
              <span class="gray"><g:message code="from"/></span> <g:textField class="datepicker" name="beginDate" size="10" value=""/>
              <span class="gray"><g:message code="to"/></span> <g:textField class="datepicker" name="endDate" size="10" value=""/>
            %{--<g:submitButton name="submit" value="${message(code:'define')}"/>
            </g:formRemote>--}%
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="theme"/></td>
            <td valign="top" class="value">
              %{--<g:formRemote name="formRemote2" url="[action: 'searchbytheme']" update="searchresults">--}%
              <g:select name="theme" from="${themes}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'non')]"/>
              %{--<g:submitButton name="submit" value="${message(code:'define')}"/>
              </g:formRemote>--}%
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="labels"/></td>
            <td valign="top" class="value">
              %{--<g:formRemote name="formRemote3" url="[action: 'searchbylabel']" update="searchresults">--}%
              <g:select multiple="true" name="labels" from="${allLabels}" style="min-height: 115px;"/>
              %{--<g:submitButton name="submit" value="${message(code:'define')}" style="vertical-align: top;"/>
              </g:formRemote>--}%
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
