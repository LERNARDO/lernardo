<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Sponsorennetzwerk bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Sponsorennetzwerk bearbeiten</h1>
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
          <tbody>
                        
          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="groupPartner.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="groupPartner.profile.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="5" cols="40" name="description" value="${fieldValue(bean: group, field: 'profile.description')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="service">
                <g:message code="groupPartner.profile.service"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="service" id="service" multiple="true" from="${grailsApplication.config.partner_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="service" id="service" multiple="true" from="${grailsApplication.config.partner_de}" optionKey="key" optionValue="value"/>
              </g:if>
              %{--<g:select class="${hasErrors(bean: group, field: 'profile.service', 'errors')}" id="service" name="service" from="['a','b']" value="${fieldValue(bean: group, field: 'profile.service')}"/>--}%
            </td>
          </tr>
                        
          </tbody>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="del" id="${group.id}" onclick="return confirm('Bist du sicher?');"><g:message code="delete"/></g:link>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>