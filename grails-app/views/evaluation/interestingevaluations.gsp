<head>
  <title>Interessante Tagebucheinträge</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Interessante Tagebucheinträge</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>Es gibt insgesamt ${evaluationInstanceList.size()} Tagebucheinträge zu Betreuten und Erziehungsberechtigten in deinem Umfeld.</p>

    <g:link class="buttonGreen" action="myevaluations" id="${entity.id}">Meine Tagebucheinträge</g:link>
    <div class="spacer"></div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluation">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="name"/>:</td>
              <td><g:link controller="${evaluation.owner.type.supertype.name +'Profile'}" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="date"/>:</td>
              <td><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="description"/>:</td>
              <td>${evaluation.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="action"/>:</td>
              <td>${evaluation.method.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="from"/>:</td>
              <td>${evaluation.writer.profile.fullName}</td>
            </tr>
          </table>
          <erp:isMeOrAdminOrOperator entity="${evaluation.writer}" current="${currentEntity}">
            <g:link class="helperButton" action="edit" id="${evaluation.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
          </erp:isMeOrAdminOrOperator>
        </div>
      </g:each>
    </ul>

  </div>
</div>
</body>
