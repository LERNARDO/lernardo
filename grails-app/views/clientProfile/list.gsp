<head>
  <meta name="layout" content="database"/>
  <title>${message(code: 'clients')}</title>
</head>
<body>

<div class="boxHeader">
  <h1><g:message code="clients"/></h1>
</div>

<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalClients, message(code: 'clients')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']" facilities="${facilities}">
    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'client')])}" /></div>
      </g:form>
      <div class="clear"></div>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'clientProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="active"/></td>
          <td valign="top" class="value">
            <g:checkBox name="active" value="true"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="gender"/></td>
          <td valign="top" class="value">
            <g:select name="gender" from="${['0':message(code:'all'),'1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="birthDate"/></td>
          <td valign="top" class="value">
            <span class="gray"><g:message code="from"/></span> <g:textField class="datepicker" name="birthDateFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField class="datepicker" name="birthDateTo" size="5"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupColony"/></td>
          <td valign="top" class="value">
            <g:select name="colony" from="${colonies}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="facility"/></td>
          <td valign="top" class="value">
            <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="client.profile.school"/></td>
          <td valign="top" class="value">
            <g:textField name="school" size="20"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="client.profile.schoolLevel"/></td>
          <td valign="top" class="value">
            <g:select name="schoolLevel" from="${schoolLevels}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
      <div class="clear"></div>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

  %{--<g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller: 'overview', action: 'searchMe', params: [client: 'yes', enabled: 'true']]" before="showspinner('#membersearch-results')" />
  <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

  <table class="default-table">
    <thead>
    <tr>
      <g:sortableColumn property="firstName" title="${message(code:'firstName')}"/>
      <g:sortableColumn property="lastName" title="${message(code:'lastName')}"/>
      <g:sortableColumn property="birthDate" title="${message(code:'birthDate')}"/>
    </tr>
    </thead>
    <tbody>
    <g:each in="${clients}" status="i" var="client">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td>
          <erp:profileImage entity="${client}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
          <g:link action="show" id="${client.id}">${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}</g:link>
        </td>
        <td>${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}</td>
        <td><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy" /></td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <g:paginate total="${totalClients}"/>
  </div>--}%

</div>
</body>