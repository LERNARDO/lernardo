<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'educator')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'educator')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: educator]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="gender"/></td>
          <td class="value">
            <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:educator,field:'profile.gender')}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="title"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.title', 'errors')}" size="15" name="title" value="${fieldValue(bean: educator, field: 'profile.title').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.firstName', 'errors')}" required="" size="25" name="firstName" value="${fieldValue(bean: educator, field: 'profile.firstName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.lastName', 'errors')}" required="" size="25" maxlength="30" name="lastName" value="${fieldValue(bean: educator, field: 'profile.lastName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="birthDate"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField name="birthDate" class="datepicker-birthday ${hasErrors(bean: educator, field: 'profile.birthDate', 'errors')}" required="" value="${formatDate(date: educator?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="bloodType"/></td>
          <td class="value">
            <g:select name="bloodType" from="${Setup.list()[0]?.bloodTypes}" value="${educator?.profile?.bloodType}" noSelection="['': message(code: 'none')]"/>
           </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.education"/></td>
          <td class="value">
            <g:select name="education" from="${Setup.list()[0]?.educations}" value="${educator?.profile?.education}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.employment"/></td>
          <td class="value">
            <g:select name="employment" from="${Setup.list()[0]?.employmentStatus}" value="${educator?.profile?.employment}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.enlisted"/></td>
          <td class="value">
            <g:select name="enlisted" from="${partner}" value="" noSelection="['': message(code: 'no')]" optionKey="id" optionValue="profile"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.interests"/></td>
          <td class="value">
            <g:textArea rows="3" cols="50" data-counter="2000" class="${hasErrors(bean: educator, field: 'profile.interests', 'errors')}" name="interests" value="${fieldValue(bean: educator, field: 'profile.interests').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.inChargeOf"/></td>
          <td class="value">
            <g:select name="inChargeOf" multiple="true" from="${Setup.list()[0]?.responsibilities}" value="${educator?.profile?.inChargeOf}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.languages"/></td>
          <td class="value">
            <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${educator?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/> #1</td>
          <td class="value">
            <g:textField class="${hasErrors(bean: educator, field: 'profile.phone1', 'errors')}" size="40" name="phone1" value="${fieldValue(bean: educator, field: 'profile.phone1').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/> #2</td>
          <td class="value">
            <g:textField class="${hasErrors(bean: educator, field: 'profile.phone2', 'errors')}" size="40" name="phone2" value="${fieldValue(bean: educator, field: 'profile.phone2').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.privMail"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: educator, field: 'profile.privEmail', 'errors')}" size="40" name="privEmail" value="${fieldValue(bean: educator, field: 'profile.privEmail').decodeHTML()}"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="entryDate"/> <span class="required-indicator">*</span></td>
              <td class="value">
                  <g:textField class="datepicker" required="" size="12" name="entryDate" value=""/>
              </td>
          </tr>

      </table>

      <h4><g:message code="educator.profile.curAddress"/></h4>
      <table>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.currentStreet', 'errors')}" size="50" name="currentStreet" value="${fieldValue(bean: educator, field: 'profile.currentStreet').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="groupColony"/></td>
          <td class="value">
            <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile"/>
          </td>
        </tr>

      </table>

      <h4><g:message code="educator.profile.origin"/></h4>
      <table>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.originStreet', 'errors')}" size="50" name="originStreet" value="${fieldValue(bean: educator, field: 'profile.originStreet').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="zip"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: educator, field: 'profile.originZip', 'errors')}" size="10" name="originZip" value="${fieldValue(bean: educator, field: 'profile.originZip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="city"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.originCity', 'errors')}" size="30" name="originCity" value="${fieldValue(bean: educator, field: 'profile.originCity').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="country"/></td>
          <td class="value">
            <g:select name="originCountry" from="${Setup.list()[0]?.nationalities}" value="${educator?.profile?.originCountry}" noSelection="['': message(code: 'unknown')]"/>
          </td>
        </tr>

      </table>

      <h4><g:message code="educator.profile.emContact"/></h4>
      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactName', 'errors')}" size="50" name="contactName" value="${fieldValue(bean: educator, field: 'profile.contactName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactStreet', 'errors')}" size="50" name="contactStreet" value="${fieldValue(bean: educator, field: 'profile.contactStreet').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="zip"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: educator, field: 'profile.contactZip', 'errors')}" size="10" name="contactZip" value="${fieldValue(bean: educator, field: 'profile.contactZip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="city"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactCity', 'errors')}" size="50" name="contactCity" value="${fieldValue(bean: educator, field: 'profile.contactCity').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="country"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactCountry', 'errors')}" size="50" name="contactCountry" value="${fieldValue(bean: educator, field: 'profile.contactCountry').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactPhone', 'errors')}" size="50" name="contactPhone" value="${fieldValue(bean: educator, field: 'profile.contactPhone').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="email"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: educator, field: 'profile.contactMail', 'errors')}" size="50" name="contactMail" value="${fieldValue(bean: educator, field: 'profile.contactMail').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="email">
        <table>
          <tr>
            %{--<td width="90" valign="middle">
              <g:message code="active"/>
              <g:checkBox name="enabled" value="${educator?.user?.enabled}"/>
            </td>--}%
            <td width="350" valign="middle">
              <g:message code="email"/> <span class="required-indicator">*</span>
              <g:textField class="${hasErrors(bean: educator, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: educator, field: 'user.email')}"/>
            </td>
          </tr>
        </table>
      </div>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>
      
    </g:form>

</div>
</body>
