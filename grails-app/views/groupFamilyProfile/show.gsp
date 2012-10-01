<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupFamily"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${group}"/> ${group.profile.fullName} <span style="font-size: 12px;">(<g:message code="groupFamily"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: group]"/>

<div class="boxGray">

    <g:render template="/templates/defaultNavigation" model="[entity: group]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupFamilyProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="groupFamilyProfile" action="management" id="${group.id}"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink style="border-right: none;" update="content" controller="publication" action="list" id="${group.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${group}"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>
      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.familyIncome"/> (${grailsApplication.config.currency}):</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.familyIncome') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.amountHousehold"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.amountHousehold') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.livingConditions"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.livingConditions').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.socioeconomicData"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.socioeconomicData').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.otherInfo"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.otherInfo').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupFamily.profile.familyProblems"/>:</td>
          <td class="two">
            <g:if test="${group.profile.familyProblems}">
              <ul>
                <g:each in="${group.profile.familyProblems}" var="problem">
                  <li>${problem}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="noData"/></div>
            </g:else>
          </td>
        </tr>

        </tbody>
      </table>

    </div>

</div>
</body>