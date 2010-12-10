<head>
  <meta name="layout" content="private"/>
  <title><g:message code="privat.workday"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="privat.workday"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>Bitte einen Tag auswählen um Zeitaufzeichnungen einzutragen:</p>

    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'showunits']" update="workdayunits" before="showspinner('#workdayunits')">
      <g:textField name="date" size="30" class="datepicker-birthday"/>
      <div class="spacer"></div>
      <g:submitButton name="submitButton" value="OK"/>
      <div class="spacer"></div>
    </g:formRemote>

    %{--<app:isOperator entity="${currentEntity}">
      <div class="zusatz">
        <h5>Kategorien <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#workdaycategories');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Performance hinzufügen"/></a></app:accessCheck></h5>
        <div class="zusatz-add" id="workdaycategories" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'addCategory']" update="workdaycategories2" before="showspinner('#workdaycategories2')">
            <table>
              <tr>
                <td valign="top"><g:message code="text"/>: </td>
                <td><g:textField size="30" name="name" value=""/></td>
              </tr>
            </table>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="workdaycategories2">
          <g:render template="workdaycategories" model="[workdaycategories: workdaycategories, entity: currentEntity]"/>
        </div>
      </div>
    </app:isOperator>--}%

    <div id="workdayunits"></div>

  </div>
</div>
</body>