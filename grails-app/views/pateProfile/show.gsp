<head>
  <meta name="layout" content="database"/>
  <title><g:message code="pate"/> - ${pate.profile}</title>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${pate}"/> ${pate.profile} <span style="font-size: 12px;">(<g:message code="pate"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: pate]"/>

<div class="boxContent">

      <g:render template="/templates/pateNavigation" model="[entity: pate]"/>

      <div class="tabnav">
        <ul>
          <li><g:link controller="pateProfile" action="show" id="${pate.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="pateProfile" action="management" id="${pate.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
          <li><g:remoteLink update="content" controller="publication" action="list" id="${pate.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${pate}"/></g:remoteLink></li>
          <li><g:remoteLink update="content" controller="msg" action="inbox" id="${pate.id}" before="showspinner('#content');"><g:message code="privat.posts"/></g:remoteLink></li>
          <li><g:remoteLink update="content" controller="appointmentProfile" action="index" id="${pate.id}" before="showspinner('#content');"><g:message code="appointments"/></g:remoteLink></li>
        </ul>
      </div>

      <div id="content">

        <h4><g:message code="profile"/></h4>
        <table>
          <tbody>

          <tr class="prop">
            <td class="one"><g:message code="firstName"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="lastName"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.lastName') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
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
            <td class="two">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+ '</div>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="city"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.city') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="street"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.street') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="country"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.country') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
          </tr>

          %{-- AAZ (01.09.2010): disabled until this feature is implemented --}%
          %{--<tr class="prop">
            <td class="one"><g:message code="pate.profile.emails"/>:</td>
            <td class="two">${fieldValue(bean: pate, field: 'profile.emails')}</td>
          </tr>--}%

          </tbody>
        </table>

      </div>

</div>

<g:render template="/templates/ajaxCommands" model="[ajax: ajax, ajaxId: ajaxId]"/>

</body>
