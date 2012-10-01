<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'groupActivity')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'groupActivity')]"/></h1>
</div>
<div class="boxGray">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">

        <table>

            <tr class="prop">
                <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
                <td class="value">
                    <g:textField data-counter="50" class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" required="" size="50" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupActivity.profile.realDuration"/></td>
                <td class="value">
                    <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="date"/></td>
                <td class="value">
                    <g:textField name="date" class="datetimepicker" value="${formatDate(date: group?.profile?.date, format: 'dd. MM. yyyy HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupActivity.profile.educationalObjective"/></td>
                <td class="value">
                    <g:select from="['succeeded','notSucceeded']" name="educationalObjective" value="${group.profile.educationalObjective}" noSelection="['': message(code: 'none')]" valueMessagePrefix="goal"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupActivity.profile.educationalObjectiveText"/></td>
                <td class="value">
                    <ckeditor:editor name="educationalObjectiveText" height="200px" width="800px" toolbar="Basic">
                        ${fieldValue(bean:group,field:'profile.educationalObjectiveText').decodeHTML()}
                    </ckeditor:editor>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="description"/></td>
                <td class="value">
                    <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                        ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
                    </ckeditor:editor>
                </td>
            </tr>

        </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>
