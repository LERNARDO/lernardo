<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'groupFamily')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'groupFamily')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">
      <div>
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.familyIncome"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.amountHousehold"/></td>
          </tr>

          <tr>
            <td width="265px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="39" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="265px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.familyIncome', 'errors')}" size="39" name="familyIncome" value="${fieldValue(bean: group, field: 'profile.familyIncome')}"/>
            </td>
            <td width="265px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.amountHousehold', 'errors')}" size="39" name="amountHousehold" value="${fieldValue(bean: group, field: 'profile.amountHousehold')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupFamily.profile.livingConditions"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.socioeconomicData"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.otherInfo"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textArea class="countable${group.profile.constraints.livingConditions.maxSize} ${hasErrors(bean: group, field: 'profile.livingConditions', 'errors')}" rows="5" cols="36" name="livingConditions" value="${fieldValue(bean: group, field: 'profile.livingConditions').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable${group.profile.constraints.socioeconomicData.maxSize} ${hasErrors(bean: group, field: 'profile.socioeconomicData', 'errors')}" rows="5" cols="36" name="socioeconomicData" value="${fieldValue(bean: group, field: 'profile.socioeconomicData').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable${group.profile.constraints.otherInfo.maxSize} ${hasErrors(bean: group, field: 'profile.otherInfo', 'errors')}" rows="5" cols="36" name="otherInfo" value="${fieldValue(bean: group, field: 'profile.otherInfo').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupFamily.profile.familyProblems"/></td>
          </tr>

          <tr>
            <td colspan="3" valign="top" class="value">
              <g:select name="familyProblems"  from="${Setup.list()[0]?.familyProblems}" value="${group?.profile?.familyProblems}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>
          
        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>