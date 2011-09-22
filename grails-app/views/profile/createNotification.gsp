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

        <g:form id="${currentEntity.id}">

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

          <table width="100%">
            <tbody>

            <tr>
              <td><g:message code="title"/>:</td>
              <td class="value"><g:textField class="${hasErrors(bean:nc,field:'subject','errors')}" name="subject" size="60" value="${fieldValue(bean:nc,field:'subject')}"/></td>
            </tr>

            <tr>
              <td><g:message code="notification.content"/>:</td>
              <td class="value ${hasErrors(bean:nc,field:'content','errors')}">
                <ckeditor:editor name="content" height="200px" toolbar="Basic">
                  ${fieldValue(bean:nc,field:'content').decodeHTML()}
                </ckeditor:editor>
              </td>
            </tr>

            </tbody>
          </table>
          <div class="buttons">
            <div class="button"><g:actionSubmit class="buttonGreen" action="saveNotification" value="${message(code: 'notification.send')}" /></div>
            <div class="button"><g:actionSubmit class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" value="${message(code: 'cancel')}" /></div>
            <div class="spacer"></div>
          </div>
        </g:form>

      </div>
    </div>
  </body>
</html>
