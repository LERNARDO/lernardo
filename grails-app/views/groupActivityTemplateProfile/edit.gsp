<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsblockvorlage bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsblockvorlage bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${group}">
      <div class="errors">
        <g:renderErrors bean="${group}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${group.id}">
      <div class="dialog">
     <table>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivityTemplate.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name">
            <label for="realDuration">
              <g:message code="groupActivityTemplate.profile.realDuration"/>
            </label>
           </td>
           <td valign="top" class="name">
                    <label for="status">
                      <g:message code="groupActivityTemplate.profile.status"/>
                    </label>
                  </td>
           </tr>
           <tr>
            <td width="500px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="75" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="170px" valign="top" class="value">
             <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/>
             </td>
             <td valign="top" class="value">
                    <g:select id="status" name="status" from="${['fertig','in Bearbeitung']}" value="${group?.profile?.status}"/>
                  </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name">
              <label for="description">
                <g:message code="groupActivityTemplate.profile.description"/>
              </label>
            </td>
            </tr>
            <tr>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="6" cols="125" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

     </table>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonGray" action="del" id="${group.id}" onclick="${app.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
