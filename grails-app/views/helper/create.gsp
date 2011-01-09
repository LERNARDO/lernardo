<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="helper.topic.create"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="helper.topic.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" params="[name:entity.id]">
      <table>
        <tbody>

        <tr>
          <td valign="top" class="label"><g:message code="helper.topic.title"/>:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'title', 'errors')}"><g:textField class="countable50" name="title" size="70" value="${fieldValue(bean:helperInstance, field:'title')}"/></td>
        </tr>

        <tr>
          <td class="label"><g:message code="text"/>:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'content', 'errors')}">
            <ckeditor:editor name="content" height="200px" width="750px" toolbar="Basic">
              ${fieldValue(bean:helperInstance,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr>
          <td class="label">Für:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'types', 'errors')}">
            %{-- <g:select id="type" name="type" from="${[Educator:'Pädagogen',User:'Moderatoren']}" value="${fieldValue(bean:helperInstance, field:'type')}" optionKey="key" optionValue="value"/></td> --}%
            <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
              <g:select id="type" name="types" multiple="true" from="${grailsApplication.config.helpProfileType_es}" value="${fieldValue(bean:helperInstance, field:'types')}" optionKey="key" optionValue="value"/>
            </g:if>
            <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
              <g:select id="type" name="types" multiple="true" from="${grailsApplication.config.helpProfileType_de}" value="${fieldValue(bean:helperInstance, field:'types')}" optionKey="key" optionValue="value"/>
            </g:if>
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list" id="${entity.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
