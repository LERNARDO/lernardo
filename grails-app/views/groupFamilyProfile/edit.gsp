<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupFamily.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupFamily.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="update" id="${group.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupFamily.profile.name"/></td>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.groupFamilyProfile.familyIncome}"><g:message code="groupFamily.profile.familyIncome"/></g:if></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.amountHousehold"/></td>
          </tr>

          <tr>
            <td width="265px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="39" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="265px" valign="top" class="value">
              <g:if test="${grailsApplication.config.groupFamilyProfile.familyIncome}">
                <g:textField class="${hasErrors(bean: group, field: 'profile.familyIncome', 'errors')}" size="39" name="familyIncome" value="${fieldValue(bean: group, field: 'profile.familyIncome')}"/>
              </g:if>
            </td>
            <td width="265px" valign="top" class="value">
              <g:if test="${grailsApplication.config.groupFamilyProfile.amountHousehold}">
                <g:textField class="${hasErrors(bean: group, field: 'profile.amountHousehold', 'errors')}" size="39" name="amountHousehold" value="${fieldValue(bean: group, field: 'profile.amountHousehold')}"/>
              </g:if>
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
            <td colspan="3" valign="top" class="name"><g:if test="${grailsApplication.config.groupFamilyProfile.familyProblems}"><g:message code="groupFamily.profile.familyProblems"/></g:if></td>
          </tr>

          <tr>
            <td colspan="3" valign="top" class="value">
              <g:if test="${grailsApplication.config.groupFamilyProfile.familyProblems}">
                <g:select class="max-textbox" name="familyProblems"  from="${grailsApplication.config.problems}" value="${group?.profile?.familyProblems}" noSelection="['': message(code: 'none')]" valueMessagePrefix="problem"/>
              </g:if>
            </td>
          </tr>
          
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${group.id}" onclick="${erp.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>