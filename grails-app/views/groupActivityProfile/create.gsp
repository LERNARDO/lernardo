<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'groupActivity')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'groupActivity')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form params="[template: template.id]">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" required="" size="50" name="fullName" value="${workAroundName.decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupActivity.profile.realDuration"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="5" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration') ?: calculatedDuration}"/> <span><g:message code="minutes"/></span> <span class="gray">(<g:message code="calculatedTotalDuration"/>: ${calculatedDuration} <g:message code="minutes"/>)</span>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupActivity.profile.educationalObjectiveText"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.educationalObjectiveText').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:group,field:'profile.description') ? fieldValue(bean:group,field:'profile.description').decodeHTML() : fieldValue(bean:template,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>
      
      <span class="ga_tab" style="border-right: none;"><g:remoteLink url="[controller: 'groupActivityProfile', action: 'updatecontent', params: [type: 'single']]" update="ga_content" before="showspinner('#ga_content')">Einmalig</g:remoteLink></span><span class="ga_tab"><g:remoteLink url="[controller: 'groupActivityProfile', action: 'updatecontent', params: [type: 'multiple']]" update="ga_content" before="showspinner('#ga_content')">Zeitraum</g:remoteLink></span>
      <div id="ga_content" class="ga_content">
        <g:render template="single" />
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>