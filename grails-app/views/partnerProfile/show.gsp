<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner"/> - ${partner.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="partner"/> - ${partner.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <table style="width: 100%">

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="name"/></td>
          <td valign="top" class="name-show"><g:message code="description"/></td>
          <td valign="top" class="name-show"><g:message code="partner.profile.website"/></td>
        </tr>

        <tr>
          <td class="value-show"><g:link action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link></td>
          <td class="value-show">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
          <td class="value-show">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

      </table>

      <table style="width: 100%">

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="phone"/></td>
          <td valign="top" class="name-show"><g:message code="partner.profile.services"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" width="200" class="value-show">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
          <td valign="top" class="value-show-block">
            <g:if test="${partner.profile.services}">
            <ul>
              <g:each in="${partner.profile.services}" var="service">
                <li>${service}</li>
              </g:each>
            </ul>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="none"/></div>
            </g:else>
          </td>
        </tr>

      </table>

      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="street"/></td>
          <td valign="top" class="name-show"><g:message code="zip"/></td>
          <td valign="top" class="name-show"><g:message code="city"/></td>
          <td valign="top" class="name-show"><g:message code="country"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
          <td valign="top" class="value-show">${partner.profile.country}</td>
        </tr>

      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${partner.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: partner, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${partner}">
              <td>
                <g:form controller="profile" action="changePassword" id="${partner.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>

    </div>

    <div class="buttons">
      <g:form id="${partner.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${partner}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: partner.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partner.profile.contacts"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#contacts');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'partnerProfile', action:'addContact', id:partner.id]" update="contacts2" before="showspinner('#contacts2');" after="toggle('#contacts');">

          <table>
            <tr>
              <td><g:message code="firstName"/>:</td>
              <td><g:textField id="cFirstName" name="firstName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="lastName"/>:</td>
              <td><g:textField id="cLastName" name="lastName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="country"/>:</td>
              <td><g:textField id="cCountry" name="country" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="zip"/>:</td>
              <td><g:textField id="cZip" name="zip" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="city"/>:</td>
              <td><g:textField id="cCity" name="city" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="street"/>:</td>
              <td><g:textField id="cStreet" name="street" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="phone"/>:</td>
              <td><g:textField id="cPhone" name="phone" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="email"/>:</td>
              <td><g:textField id="cEmail" name="email" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactFunction"/>:</td>
              <td><g:textField id="cFunction" name="function" size="30"/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="[partner: partner, entity: currentEntity]"/>
      </div>
    </div>

    <g:render template="/templates/links" model="[entity: partner]"/>

  </div>
</div>
</body>
