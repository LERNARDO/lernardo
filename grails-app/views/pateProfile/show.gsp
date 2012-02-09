<head>
  <meta name="layout" content="database"/>
  <title><g:message code="pate"/> - ${pate.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="pate"/> - ${pate.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      <g:render template="/templates/pateNavigation" model="[entity: pate]"/>

      <div class="tabnav">
        <ul>
          <li><g:link controller="pateProfile" action="show" id="${pate.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="publication" action="list" id="${pate.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${pate}"/></g:remoteLink></li>
          <li><g:link controller="msg" action="inbox" id="${pate.id}"><g:message code="privat.posts"/></g:link></li>
          <li><g:link style="border-right: none" controller="appointmentProfile" action="index" id="${pate.id}"><g:message code="appointments"/></g:link></li>
        </ul>
      </div>

      <div id="content">

        <h4><g:message code="profile"/></h4>
        <table>
          <tbody>

          <tr class="prop">
            <td class="one"><g:message code="firstName"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="lastName"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.lastName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="pate.profile.motherTongue"/>:</td>
            <td class="two">${pate.profile.motherTongue}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="pate.profile.languages"/>:</td>
            <td class="two">
              <g:if test="${pate.profile.languages}">
                <ul>
                  <g:each in="${pate.profile.languages}" var="language">
                    <li>${language}</li>
                  </g:each>
                </ul>
              </g:if>
              <g:else>
                <div class="italic">${message(code: 'noData')}</div>
              </g:else>
            </td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="zip"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="city"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="street"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="country"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.country') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          %{-- AAZ (01.09.2010): disabled until this feature is implemented --}%
          %{--<tr class="prop">
            <td class="one"><g:message code="pate.profile.emails"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.emails')}</td>
          </tr>--}%

          </tbody>
        </table>

        <div class="email">
          <table width="100%">
            <tr>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
                <td>
                  <span class="bold"><g:message code="active"/> </span>
                  <g:formatBoolean boolean="${pate.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
                </td>
              </erp:accessCheck>
              <td>
                <span class="bold"><g:message code="email"/>: </span>
                ${fieldValue(bean: pate, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
              </td>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${pate}">
                <td>
                  <g:form controller="profile" action="changePassword" id="${pate.id}">
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
          <h5><g:message code="pate.profile.gcs"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#godchildren');
          return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
          <div class="zusatz-add" id="godchildren" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${pate.id}" before="showspinner('#remoteClients')"/>
          <div id="remoteClients"></div>

          </div>
          <div class="zusatz-show" id="godchildren2">
            <g:render template="godchildren" model="[godchildren: godchildren, pate: pate, entity: currentEntity]"/>
          </div>
        </div>

      </div>

  </div>
</div>
</body>
