<head>
  <meta name="layout" content="private"/>
  <title><g:message code="comments"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="comments"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div style="border: 1px solid #ccc; border-radius: 5px; background: #fefefe; padding: 5px; margin: 0 0 10px 0;">
      <g:formRemote name="formRemote" url="[controller:'comment', action:'updatelist']" update="results" before="showspinner('#results')">
        <table>
          <tr>
            <td class="bold" valign="top" style="width: 100px;"><g:message code="period"/>:</td>
            <td><g:textField class="datepicker" name="dateFrom" value="${formatDate(date: new Date() - 7, format: 'dd. MM. yyyy')}"/> <g:message code="to"/> <g:textField class="datepicker" name="dateTo" value="${formatDate(date: new Date(), format: 'dd. MM. yyyy')}"/></td>
          </tr>
          <tr>
            <td class="bold" valign="top"><g:message code="ex"/>:</td>
            <td>
              <g:checkBox name="activitytemplates"/> <g:message code="activityTemplates"/><br/>
              <g:checkBox name="activities"/> <g:message code="activities"/><br/>
              <g:checkBox name="groupactivitytemplates"/> <g:message code="groupActivityTemplates"/><br/>
              <g:checkBox name="groupactivities"/> <g:message code="groupActivities"/><br/>
              <g:checkBox name="projecttemplates"/> <g:message code="projectTemplates"/><br/>
              <g:checkBox name="projects"/> <g:message code="projects"/>
            </td>
          </tr>
        </table>
        <g:submitButton name="submitButton" value="Anzeigen"/>
        <div class="clear"></div>
      </g:formRemote>
    </div>

    <div id="results">
    </div>

  </div>
</div>
</body>
