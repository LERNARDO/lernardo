<head>
  <meta name="layout" content="database"/>
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

    <g:render template="/templates/partnerNavigation" model="[entity: partner]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="partnerProfile" action="show" id="${partner.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${partner.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${partner}"/></g:remoteLink></li>
        <li><g:link controller="msg" action="inbox" id="${partner.id}"><g:message code="privat.posts"/></g:link></li>
        <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${partner.id}"><g:message code="appointments"/></g:link></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: pate, field: 'profile.fullName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="partner.profile.website"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="phone"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="partner.profile.services"/>:</td>
          <td class="two">
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

        <tr class="prop">
          <td class="one"><g:message code="street"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        %{--<tr class="prop">
          <td class="one"><g:message code="zip"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="city"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="country"/>:</td>
          <td class="two">${fieldValue(bean: partner, field: 'profile.country') ?: '<div class="italic">' + message(code: 'noData') + '</div>'}</td>
        </tr>--}%

        <tr class="prop">
          <td class="one"><g:message code="groupColony"/>:</td>
          <td class="two"><g:if test="${colony}"><g:link controller="${colony.type.supertype.name + 'Profile'}" action="show" id="${colony.id}">${colony.profile.zip} ${colony.profile.fullName}</g:link></g:if><g:else><div class="italic"><g:message
              code="noData"/></div></g:else></td>
        </tr>

        </tbody>
      </table>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${partner.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: partner, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:accessCheck types="['Betreiber']" me="${partner}">
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

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="partner.profile.contacts"/> <erp:accessCheck types="['Betreiber']"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#contacts');
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

            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="contacts2">
          <g:render template="contacts" model="[partner: partner]"/>
        </div>
      </div>

      <g:render template="/templates/links" model="[entity: partner]"/>

    </div>

  </div>
</div>
</body>
