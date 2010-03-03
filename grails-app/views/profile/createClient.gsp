<%@ page contentType="text/html;charset=UTF-8" %>
<html>

  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Betreuten anlegen</title>
  </head>

  <body>
    <div class="headerBlue">
      <h1>Betreuten anlegen</h1>
    </div>
    <div class="boxGray">

      <g:hasErrors bean="${entityInstance}">
        <div class="errors">
          <g:renderErrors bean="${entityInstance}" as="list" />
        </div>
      </g:hasErrors>

      <g:form action="saveClient" method="post" id="${entityInstance.id}" params="[entity:entity.name]">

        <h1>Notwendige Angaben</h1>
        <table>
            <tbody>

                <tr>
                  <td class="label">Name:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.fullName','errors')}"><g:textField name="fullName" size="30" value="${fieldValue(bean:entityInstance, field:'profile.fullName')}"/></td>
                </tr>

                <tr>
                  <td class="label">Kurzname:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'name','errors')}"><g:textField name="name" size="30" value="${fieldValue(bean:entityInstance, field:'name')}"/></td>
                </tr>

                <tr>
                  <td class="label">E-Mail:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'user.email','errors')}"><g:textField name="email" size="30" value="${fieldValue(bean:entityInstance, field:'user.email')}"/></td>
                </tr>

                <tr>
                  <td class="label">Hort:</td>
                  <td class="value"><g:select name="facility" from="${availFacilities}" optionKey="id" optionValue="name"/></td>
                </tr>

            </tbody>
        </table>

        <h1>Zusätzliche Angaben</h1>
        <table>
          <tbody>

                <tr>
                  <td class="label">Geburtstag:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.birthDate','errors')}"><g:datePicker name="birthDate" value="" precision="day" years="${1900..Calendar.getInstance().get(Calendar.YEAR)}"/></td>
                </tr>

                <tr>
                  <td class="label">PLZ:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.PLZ','errors')}"><g:textField name="PLZ" size="30" value="${fieldValue(bean:entityInstance, field:'profile.PLZ')}"/></td>
                </tr>

                <tr>
                  <td class="label">Stadt:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.city','errors')}"><g:textField name="city" size="30" value="${fieldValue(bean:entityInstance,field:'profile.city')}"/></td>
                </tr>

                <tr>
                  <td class="label">Straße:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.street','errors')}"><g:textField name="street" size="30" value="${fieldValue(bean:entityInstance,field:'profile.street')}"/></td>
                </tr>

                <tr>
                  <td class="label">Telefon:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.tel','errors')}"><g:textField name="tel" size="30" value="${fieldValue(bean:entityInstance,field:'profile.tel')}"/></td>
                </tr>

                <tr>
                  <td class="label">Geschlecht:</td>
                  <td class="value ${hasErrors(bean:entityInstance,field:'profile.tel','errors')}"><g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:entityInstance,field:'profile.gender')}" optionKey="key" optionValue="value"/></td>
                </tr>

            </tbody>
        </table>

        <div class="buttons">
            <g:submitButton name="submitButton" value="Anlegen" />
            <g:link class="buttonGray" controller="profile" action="showProfile" params="[name:entity.name]">Abbrechen</g:link>
            <div class="spacer"></div>
        </div>

      </g:form>
    </div>

  </body>
</html>