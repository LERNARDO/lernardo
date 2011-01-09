<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointment.profile.create"/></title>
</head>
<body>

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="appointment.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: appointmentProfileInstance]"/>

    <g:form action="save">

      <div class="property">
        <g:message code="appointment.profile.fullName"/> <br/>
        <g:textField class="countable50 ${hasErrors(bean:appointmentProfileInstance,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.fullName').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.description"/> <br/>
        <g:textArea class="${hasErrors(bean:appointmentProfileInstance,field:'profile.description','errors')}" rows="5" cols="40" name="description" value="${fieldValue(bean:appointmentProfileInstance,field:'profile.description').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.beginDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.beginDate','errors')}" size="18" name="beginDate" value="${appointmentProfileInstance?.profile?.beginDate?.format('dd. MM. yyyy, HH:mm')}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.endDate"/> <br/>
        <g:textField class="datetimepicker2 ${hasErrors(bean:appointmentProfileInstance,field:'profile.endDate','errors')}" size="18" name="endDate" value="${appointmentProfileInstance?.profile?.endDate?.format('dd. MM. yyyy, HH:mm')}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.allDay"/> <br/>
        <g:checkBox name="allDay" value="${appointmentProfileInstance?.profile?.allDay}"/>
      </div>

      <div class="property">
        <g:message code="appointment.profile.isPrivate"/> <br/>
        <g:checkBox name="isPrivate" value="${appointmentProfileInstance?.profile?.isPrivate}"/>
      </div>

      <div class="clear"></div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
