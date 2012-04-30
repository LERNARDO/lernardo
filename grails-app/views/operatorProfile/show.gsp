<head>
  <meta name="layout" content="database"/>
  <title><g:message code="profile"/> - ${operator.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="profile"/> - ${operator.profile.fullName}</h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/operatorNavigation" model="[entity: operator]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="operatorProfile" action="show" id="${operator.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${operator.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${operator}"/></g:remoteLink></li>
        <li><g:link controller="msg" action="inbox" id="${operator.id}"><g:message code="privat.posts"/></g:link></li>
        <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${operator.id}"><g:message code="appointments"/></g:link></li>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="email"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="zip"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.zip') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="city"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="street"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.description') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="phone"/>:</td>
          <td class="two">${fieldValue(bean: operator, field: 'profile.phone') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

      %{--<div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${operator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: operator, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}
            </td>
            <erp:accessCheck types="['Betreiber']" me="${operator}">
              <td>
                <g:form controller="profile" action="changePassword" id="${operator.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>--}%

    <h4><g:message code="management"/></h4>
    <div class="zusatz">
      <h5><g:message code="facilities"/> <erp:accessCheck me="${operator}"><a onclick="toggle('#facilities'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'operatorProfile', action: 'addFacility', id: operator.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, operator: operator]"/>
      </div>
    </div>

    </div>

  </div>
</div>
</body>