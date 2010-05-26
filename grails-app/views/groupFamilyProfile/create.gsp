<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Familie anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Familie anlegen</h1>
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
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupFamily.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="livingConditions">
                <g:message code="groupFamily.profile.livingConditions"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.livingConditions', 'errors')}" rows="5" cols="40" name="livingConditions" value="${fieldValue(bean: group, field: 'profile.livingConditions')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="socioeconomicData">
                <g:message code="groupFamily.profile.socioeconomicData"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.socioeconomicData', 'errors')}" rows="5" cols="40" name="socioeconomicData" value="${fieldValue(bean: group, field: 'profile.socioeconomicData')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="otherInfo">
                <g:message code="groupFamily.profile.otherInfo"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.otherInfo', 'errors')}" rows="5" cols="40" name="otherInfo" value="${fieldValue(bean: group, field: 'profile.otherInfo')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="familyProblems">
                <g:message code="groupFamily.profile.familyProblems"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="familyProblems" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="familyProblems" id="familyProblems" multiple="true" from="${grailsApplication.config.problems_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>
          
          <tr class="prop">
            <td valign="top" class="name">
              <label for="familyIncome">
                <g:message code="groupFamily.profile.familyIncome"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.familyIncome', 'errors')}" id="familyIncome" name="familyIncome" value="${fieldValue(bean: group, field: 'profile.familyIncome')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="amountHousehold">
                <g:message code="groupFamily.profile.amountHousehold"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.amountHousehold', 'errors')}" id="amountHousehold" name="amountHousehold" value="${fieldValue(bean: group, field: 'profile.amountHousehold')}"/>
            </td>
          </tr>

          </tbody>
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