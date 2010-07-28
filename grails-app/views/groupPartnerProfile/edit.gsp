<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Sponsorennetzwerk bearbeiten</title>
</head>
<body>
<div class="headerGreen">
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
            <td valign="top" class="name">
              <label for="description">
                <g:message code="groupPartner.profile.description"/>
              </label>
            </td>

          </tr>
          <tr class="prop">

            <td width="200" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" rows="27" id="fullName" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable${group.profile.constraints.description.maxSize} ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="2" cols="93" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>


          <tr class="prop">
            <td>&nbsp;</td>
            <td valign="top" class="name">
              <label for="service">
                <g:message code="groupPartner.profile.service"/>
              </label>
            </td>
          </tr>
          <tr class="prop">
            <td>&nbsp;</td>
            <td class="drop-down-280" valign="top">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="service" id="service" from="${grailsApplication.config.partner_es}" optionKey="key" optionValue="value" value="${group.profile.service}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="service" id="service" from="${grailsApplication.config.partner_de}" optionKey="key" optionValue="value" value="${group.profile.service}"/>
              </g:if>
              %{--<g:select class="${hasErrors(bean: group, field: 'profile.service', 'errors')}" id="service" name="service" from="['a','b']" value="${fieldValue(bean: group, field: 'profile.service')}"/>--}%
            </td>
          </tr>
                        
          </tbody>
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