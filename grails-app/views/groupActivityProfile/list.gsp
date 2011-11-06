<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivities"/></title>
</head>
<body>

%{--<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityTemplateProfile" action="index"><g:message code="groupActivityTemplates"/></g:link></h1>
  </div>
</div>--}%
<div class="boxGreen">
  <div class="second">
    <h1><g:message code="groupActivities"/></h1>
  </div>
</div>
%{--<div class="clearFloat"></div>--}%

<div class="boxGray">
  <div class="second">

    <div style="margin-bottom: 5px;">
      <table>
        <tr>
          <td class="bold" style="padding-right: 10px;"><g:message code="name"/>:</td>
          <td>
            <g:remoteField size="30" name="instantSearch" update="searchresults" paramName="name" url="[action:'searchbyname']" before="showspinner('#searchresults')" />
          </td>
        </tr>
        <tr>
          <td class="bold"><g:message code="date"/>:</td>
          <td>
            <g:formRemote name="formRemote" url="[action: 'searchbydate']" update="searchresults">
              <span class="gray"><g:message code="from"/></span> <g:textField class="datepicker" name="beginDate" size="10" value=""/>
              <span class="gray"><g:message code="to"/></span> <g:textField class="datepicker" name="endDate" size="10" value=""/>
              <g:submitButton name="submit" value="${message(code:'define')}"/>
            </g:formRemote>
          </td>
        </tr>
        <tr>
          <td class="bold"><g:message code="theme"/>:</td>
          <td>
            <g:formRemote name="formRemote2" url="[action: 'searchbytheme']" update="searchresults">
              <g:select name="theme" from="${themes}" optionKey="id" optionValue="profile"/>
              <g:submitButton name="submit" value="${message(code:'define')}"/>
            </g:formRemote>
          </td>
        </tr>
        <tr>
          <td class="bold" valign="top"><g:message code="labels"/>:</td>
          <td>
            <g:formRemote name="formRemote3" url="[action: 'searchbylabel']" update="searchresults">
              <g:select multiple="true" name="labels" from="${allLabels}" style="min-height: 115px;"/>
              <g:submitButton name="submit" value="${message(code:'define')}" style="vertical-align: top;"/>
            </g:formRemote>
          </td>
        </tr>
      </table>
    </div>

    <div id="searchresults">
    </div>

  </div>
</div>
</body>
