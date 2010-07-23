<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Familie bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Familie bearbeiten</h1>
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
                <g:message code="groupFamily.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="familyIncome">
                <g:message code="groupFamily.profile.familyIncome"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="amountHousehold">
                <g:message code="groupFamily.profile.amountHousehold"/>
              </label>
            </td>
          </tr>
          <tr>
            <td width="265px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="39" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="265px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.familyIncome', 'errors')}" size="39" id="familyIncome" name="familyIncome" value="${fieldValue(bean: group, field: 'profile.familyIncome')}"/>
            </td>
            <td width="265px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.amountHousehold', 'errors')}" size="39" id="amountHousehold" name="amountHousehold" value="${fieldValue(bean: group, field: 'profile.amountHousehold')}"/>
            </td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="livingConditions">
                <g:message code="groupFamily.profile.livingConditions"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="socioeconomicData">
                <g:message code="groupFamily.profile.socioeconomicData"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="otherInfo">
                <g:message code="groupFamily.profile.otherInfo"/>
              </label>
            </td>
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
            <td colspan="3" valign="top" class="name">
              <label for="familyProblems">
                <g:message code="groupFamily.profile.familyProblems"/>
              </label>
            </td>
          </tr>
          <tr>
            <td colspan="3" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="familyProblems" class="max-textbox" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="familyProblems" class="max-textbox" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${group.id}" onclick="${app.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>