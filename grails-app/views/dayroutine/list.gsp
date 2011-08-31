<head>
  <meta name="layout" content="private"/>
  <title><g:message code="dayroutine"/></title>
</head>

<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="dayroutine"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p><g:message code="dayroutine.create"/> <a onclick="toggle('#newroutine');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code:'dayroutine.create')}"/></a></p>
    <div id="newroutine" style="display:none; border: 1px solid #ccc; border-radius: 5px; background: #fefefe; padding: 5px; margin: 0 0 10px 0;">
      <g:formRemote name="formRemote" url="[controller:'dayroutine', action:'save', id:entity.id]" update="dayroutine" before="showspinner('#dayroutine')">
        <table>
          <tr>
            <td class="bold" valign="top"><g:message code="period"/>:</td>
            <td><g:select name="dateFromHour" from="${0..23}"/>:<g:select name="dateFromMinute" from="${0..59}"/> <g:message code="to"/> <g:select name="dateToHour" from="${0..23}"/>:<g:select name="dateToMinute" from="${0..59}"/> <g:message code="clock"/></td>
          </tr>
          <tr>
            <td class="bold" style="width: 150px;" valign="top">Tätigkeit:</td>
            <td><g:textField name="title" size="30"/></td>
          </tr>
          <tr>
            <td class="bold" valign="top"><g:message code="description"/>:</td>
            <td><g:textArea name="description" rows="4" cols="50"/></td>
          </tr>
          <tr>
            <td class="bold" valign="top">Tage</td>
            <td>
              <g:checkBox name="monday"/> <g:message code="monday"/><br/>
              <g:checkBox name="tuesday"/> <g:message code="tuesday"/><br/>
              <g:checkBox name="wednesday"/> <g:message code="wednesday"/><br/>
              <g:checkBox name="thursday"/> <g:message code="thursday"/><br/>
              <g:checkBox name="friday"/> <g:message code="friday"/><br/>
              <g:checkBox name="saturday"/> <g:message code="saturday"/><br/>
              <g:checkBox name="sunday"/> <g:message code="sunday"/><br/>
            </td>
          </tr>
        </table>
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <div class="clear"></div>
      </g:formRemote>
    </div>

    <div id="dayroutine">
      <g:render template="routineday" model="[routines: routines, entity: entity, day: day]"/>
    </div>

  </div>
</div>

</body>