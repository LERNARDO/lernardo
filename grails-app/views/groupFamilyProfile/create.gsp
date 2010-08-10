<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupFamily.profile.create"/></title>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="groupFamily.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${group}">
      <div class="errors">
        <g:renderErrors bean="${group}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupFamily.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.familyIncome"/></td>
            <td valign="top" class="name"><g:message code="groupFamily.profile.amountHousehold"/></td>
          </tr>

          <tr>
            <td width="265px" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="39" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
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
              <g:textArea class="countable500 ${hasErrors(bean: group, field: 'profile.livingConditions', 'errors')}" rows="5" cols="36" name="livingConditions" value="${fieldValue(bean: group, field: 'profile.livingConditions')}"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable500 ${hasErrors(bean: group, field: 'profile.socioeconomicData', 'errors')}" rows="5" cols="36" name="socioeconomicData" value="${fieldValue(bean: group, field: 'profile.socioeconomicData')}"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable500 ${hasErrors(bean: group, field: 'profile.otherInfo', 'errors')}" rows="5" cols="36" name="otherInfo" value="${fieldValue(bean: group, field: 'profile.otherInfo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupFamily.profile.familyProblems"/></td>
          </tr>

          <tr>
            <td colspan="3" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="familyProblems" class="max-textbox" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_es}" optionKey="key" optionValue="value" value="${group.profile.familyProblems}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="familyProblems" class="max-textbox" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_de}" optionKey="key" optionValue="value" value="${group.profile.familyProblems}"/>
              </g:if>
            </td>
          </tr>

        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>