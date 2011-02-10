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

    <p>Es gibt insgesamt ${evaluationInstanceList.size()} Tagebucheinträge zu Betreuten in deinem Umfeld.</p>

    <g:link class="buttonGreen" action="myevaluations" id="${entity.id}">Meine Tagebucheinträge</g:link>
    <div class="spacer"></div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluationInstance">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="client"/>:</td>
              <td><g:link controller="clientProfile" action="show" id="${evaluationInstance.owner.id}" params="[entity:evaluationInstance.owner.id]">${evaluationInstance.owner.profile.fullName}</g:link></td>
            </tr>
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
        </div>
      </g:each>
    </ul>

  </div>
</div>
</body>
