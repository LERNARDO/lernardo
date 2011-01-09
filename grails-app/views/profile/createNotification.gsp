<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title><g:message code="notification.create"/></title>
  </head>
  <body>
    <div class="boxHeader">
      <div class="second">
        <h1><g:message code="notification.create"/></h1>
      </div>
    </div>
    <div class="boxGray">
      <div class="second">

        <g:hasErrors bean="${nc}">
          <div class="errors">
            <g:renderErrors bean="${nc}" as="list"/>
          </div>
        </g:hasErrors>

        <p><g:message code="notification.info"/>:</p>

        <g:form action="saveNotification">

          <p class="${hasErrors(bean:nc,field:'selection','errors')}">
            <g:checkBox name="user" value="${nc?.user}"/> <g:message code="user"/><br/>
            <g:checkBox name="operator" value="${nc?.operator}"/> <g:message code="operator"/><br/>
            <g:checkBox name="client" value="${nc?.client}"/> <g:message code="clients"/><br/>
            <g:checkBox name="educator" value="${nc?.educator}"/> <g:message code="educators"/><br/>
            <g:checkBox name="parent" value="${nc?.parent}"/> <g:message code="parents"/><br/>
            <g:checkBox name="child" value="${nc?.child}"/> <g:message code="children"/><br/>
            <g:checkBox name="pate" value="${nc?.pate}"/> <g:message code="pate"/><br/>
            <g:checkBox name="partner" value="${nc?.partner}"/> <g:message code="partners"/><br/>
          </p>

          <table class="form">
            <tbody>

            <tr>
              <td><g:message code="notification.title"/>:</td>
              <td class="value"><g:textField class="${hasErrors(bean:nc,field:'subject','errors')}" name="subject" size="60" value="${fieldValue(bean:nc,field:'subject')}"/></td>
            </tr>

            <tr>
              <td><g:message code="notification.content"/>:</td>
              <td class="value ${hasErrors(bean:nc,field:'content','errors')}">
                <ckeditor:editor name="content" height="200px" width="700px" toolbar="Basic">
                  ${fieldValue(bean:nc,field:'content').decodeHTML()}
                </ckeditor:editor>
              </td>
            </tr>

            </tbody>
          </table>
          <div class="buttons">
            <g:submitButton name="saveNotification" value="${message(code:'notification.send')}"/>
            <g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}"><g:message code="cancel"/></g:link>
            <div class="spacer"></div>
          </div>
        </g:form>

      </div>
    </div>
  </body>
</html>
