<head>
  <title>Tagebucheinträge</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Tagebucheinträge für ${entity.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      Es gibt insgesamt ${evaluationInstanceTotal} Tagebucheinträge für ${entity.profile.fullName}
    </div>

    <g:link class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:link>
    <div class="spacer"></div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluationInstance">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="date"/>:</td>
              <td><g:formatDate date="${evaluationInstance.dateCreated}" format="dd. MM. yyyy"/></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="description"/>:</td>
              <td>${evaluationInstance.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="action"/>:</td>
              <td>${evaluationInstance.method.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="from"/>:</td>
              <td>${evaluationInstance.writer.profile.fullName}</td>
            </tr>
          </table>
          <g:link class="helperButton" action="edit" id="${evaluationInstance.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
        </div>
      </g:each>
    </ul>

    <div class="paginateButtons">
      <g:paginate action="list" total="${evaluationInstanceTotal}" id="${entity.id}"/>
    </div>

  </div>
</div>
</body>
