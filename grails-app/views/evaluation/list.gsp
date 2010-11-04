<head>
  <title>Tagebucheinträge</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Tagebucheinträge für ${entity.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>Es gibt insgesamt ${evaluationInstanceList.size()} Tagebucheinträge für ${entity.profile.fullName}.</p>

    <div id="newHelper">
      <g:link class="buttonGreen" action="create" id="${entity.id}">Neuen Tagebucheintrag erstellen</g:link>
      <div class="spacer"></div>
    </div>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluationInstance">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="strong vtop">Datum:</td>
              <td><g:formatDate date="${evaluationInstance.dateCreated}" format="dd. MM. yyyy"/></td>
            </tr>
            <tr>
              <td class="strong vtop">Beschreibung:</td>
              <td>${evaluationInstance.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="strong vtop">Maßnahme:</td>
              <td>${evaluationInstance.method.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="strong vtop">Von:</td>
              <td>${evaluationInstance.writer.profile.fullName}</td>
            </tr>
          </table>
          <g:link class="helperButton" action="edit" id="${evaluationInstance.id}" params="[entity:entity.id]">Bearbeiten</g:link>
        </div>
      </g:each>
    </ul>

  </div>
</div>
</body>
