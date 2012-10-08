<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="administration" />
    <title><g:message code="notification.create"/></title>
  </head>
  <body>
    <div class="boxHeader">
      <h1><g:message code="notification.create"/></h1>
    </div>
    <div class="boxContent">

        <g:hasErrors bean="${nc}">
          <div class="errors">
            <g:renderErrors bean="${nc}" as="list"/>
          </div>
        </g:hasErrors>

        <div class="info-msg"><g:message code="notification.info"/>:</div>

        <g:form id="${currentEntity.id}">

          <div style="margin-bottom: 15px;" class="${hasErrors(bean:nc,field:'selection','errors')}">
            <table>
              <tr>
                <td style="padding: 0 10px; line-height: 20px;">
                  <g:checkBox name="user" value="${nc?.user}"/> <g:message code="user"/><br/>
                  <g:checkBox name="operator" value="${nc?.operator}"/> <g:message code="operator"/><br/>
                  <g:checkBox name="client" value="${nc?.client}"/> <g:message code="clients"/><br/>
                  <g:checkBox name="educator" value="${nc?.educator}"/> <g:message code="educators"/>
                </td>
                <td style="padding: 0 10px; line-height: 20px;">
                  <g:checkBox name="parent" value="${nc?.parent}"/> <g:message code="parents"/><br/>
                  <g:checkBox name="child" value="${nc?.child}"/> <g:message code="children"/><br/>
                  <g:checkBox name="pate" value="${nc?.pate}"/> <g:message code="pate"/><br/>
                  <g:checkBox name="partner" value="${nc?.partner}"/> <g:message code="partners"/>
                </td>
              </tr>
            </table>
          </div>
          
          <table>
          
            <tr class="prop">
              <td class="name"><g:message code="title"/></td>
              <td class="value">
                <g:textField class="${hasErrors(bean:nc,field:'subject','errors')}" name="subject" size="50" value="${fieldValue(bean:nc,field:'subject')}"/>
              </td>
            </tr>

            <tr class="prop">
              <td class="name"><g:message code="content"/></td>
              <td class="value">
                <ckeditor:editor name="content" height="200px" toolbar="Basic">
                  ${fieldValue(bean:nc,field:'content').decodeHTML()}
                </ckeditor:editor>
              </td>
            </tr>
          
          </table>

          <div class="buttons cleared">
            <div class="button"><g:actionSubmit class="buttonGreen" action="saveNotification" value="${message(code: 'notification.send')}" /></div>
            <div class="button"><g:actionSubmit class="buttonGray" controller="${currentEntity.type.supertype.name + 'Profile'}" action="show" value="${message(code: 'cancel')}" /></div>
          </div>
        </g:form>

    </div>
  </body>
</html>
