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

<erp:isOperator entity="${currentEntity}">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="evaluation" action="listall" id="${entity.id}">Alle Tagebucheinträge</g:link></h1>
    </div>
  </div>
</erp:isOperator>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p>Du hast insgesamt ${evaluationInstanceTotal} Tagebucheinträge erstellt.</p>

    <g:link class="buttonGreen" action="interestingevaluations" id="${entity.id}">Interessante Tagebucheinträge</g:link>
    <div class="spacer"></div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluationInstance">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop">Betreuter:</td>
              <td><g:link controller="clientProfile" action="show" id="${evaluationInstance.owner.id}" params="[entity:evaluationInstance.owner.id]">${evaluationInstance.owner.profile.fullName}</g:link></td>
            </tr>
            <tr>
              <td class="bold vtop">Datum:</td>
              <td><g:formatDate date="${evaluationInstance.dateCreated}" format="dd. MM. yyyy"/></td>
            </tr>
            <tr>
              <td class="bold vtop">Beschreibung:</td>
              <td>${evaluationInstance.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop">Maßnahme:</td>
              <td>${evaluationInstance.method.decodeHTML()}</td>
            </tr>
            %{--<tr>
              <td class="strong vtop">Von:</td>
              <td>${evaluationInstance.writer.profile.fullName}</td>
            </tr>--}%
          </table>
        </div>
      </g:each>
    </ul>

    <div class="paginateButtons">
      <g:paginate action="myevaluations" total="${evaluationInstanceTotal}" id="${entity.id}"/>
    </div>

  </div>
</div>
</body>
