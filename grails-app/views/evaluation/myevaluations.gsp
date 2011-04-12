<head>
  <title>Meine Tagebucheinträge</title>
  <meta name="layout" content="private"/>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1>Meine Tagebucheinträge</h1>
  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="evaluation" action="listall" id="${entity.id}">Alle Tagebucheinträge</g:link></h1>
    </div>
  </div>
</erp:accessCheck>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p>Du hast insgesamt ${evaluationInstanceTotal} Tagebucheinträge erstellt.</p>

    <g:link class="buttonGreen" action="interestingevaluations" id="${entity.id}">Interessante Tagebucheinträge</g:link>
    <div class="spacer"></div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluation">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="client"/>:</td>
              <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="date"/>:</td>
              <td><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy"/></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="description"/>:</td>
              <td>${evaluation.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="action"/>:</td>
              <td>${evaluation.method.decodeHTML()}</td>
            </tr>
          </table>
          <erp:isMeOrAdminOrOperator entity="${evaluation.writer}" current="${currentEntity}">
            <g:link class="helperButton" action="edit" id="${evaluation.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
          </erp:isMeOrAdminOrOperator>
        </div>
      </g:each>
    </ul>

    <div class="paginateButtons">
      <g:paginate action="myevaluations" total="${evaluationInstanceTotal}" id="${entity.id}"/>
    </div>

  </div>
</div>
</body>
