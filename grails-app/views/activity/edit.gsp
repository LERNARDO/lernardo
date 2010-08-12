<head>
  <meta name="layout" content="private"/>
  <title>Aktivität bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivität bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: activity]"/>

    <g:form action="update" method="post" id="${activity.id}">
      Vorlage:<app:getTemplate entity="${activity}">
      <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
    </app:getTemplate>
      <table>
        <tbody>

        <tr>
          <td valign="bottom" class="label">Titel:</td>
          <td valign="bottom" class="label">Datum:</td>
          <td valign="bottom" class="label">Dauer in Minuten:</td>
        </tr>

        <tr>
          <td width="220" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.fullName', 'errors')}"><g:textField class="countable${activity.profile.constraints.fullName.maxSize}" name="fullName" size="30" value="${fieldValue(bean:activity, field:'profile.fullName').decodeHTML()}"/>
          </td>
          <td width="350" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.date', 'errors')}"><g:datePicker name="date" value="${activity.profile.date}" precision="minute"/>
          </td>
          <td width="220" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.duration', 'errors')}"><g:textField name="duration" value="${fieldValue(bean:activity, field:'profile.duration')}"/>
          </td>
        </tr>

        <tr>
          <td valign="bottom" class="label">Einrichtung:</td>
          <td valign="bottom" class="label">Betreute:</td>
          <td valign="bottom" class="label">Pädagogen:</td>
        </tr>

        <tr>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'facility', 'errors')}">
            <g:select class="drop-down-205" name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
          </td>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'clients', 'errors')}">
            <g:select multiple="true" optionKey="id" optionValue="profile" from="${clients}" size="10" class="long-field" name="clients"/>
          </td>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'educators', 'errors')}">
            <g:select multiple="true" optionKey="id" optionValue="profile" from="${educators}" name="educators"/>
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${activity.id}" params="[name:currentEntity.name]"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>