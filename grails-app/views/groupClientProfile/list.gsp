<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupClients"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="groupClients"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[totalGroupClients, message(code: 'groupClients')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupClient')])}"/></div>
          <div class="clear"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller: 'overview', action: 'searchMe', params: [groupClient: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'name')}"/>
        <th><g:message code="clients"/></th>
        <th><g:message code="export"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><erp:getGroupClientsCount entity="${group}"/></td>
          <td>
            <a href="#" onclick="jQuery('#modal${i}').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</a> <g:link controller="excel" action="report" id="${group.id}" params="[type: 'clientgroup']"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" align="top"/> XLS</g:link>
          </td>
        </tr>
        <div id="modal${i}" style="display: none;">
          <g:form action="createpdf" id="${group.id}">
            <p><g:message code="selectPageFormat"/></p>
            <g:radioGroup name="pageformat" labels="['DIN A4 Hoch (210mm × 297mm)','DIN A4 Quer (297mm × 210mm)','Letter Hoch (216mm × 279mm)','Letter Quer (279mm × 216mm)']" values="[1,2,3,4]" value="1">
              <p>${it.radio} ${it.label}</p>
            </g:radioGroup>
            <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
          </g:form>
        </div>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalGroupClients}"/>
    </div>

  </div>
</div>


</body>
