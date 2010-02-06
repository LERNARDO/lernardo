<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Beurteilungen</title>
  <g:javascript library="jquery"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Beurteilung für ${entity.profile.fullName}</h1>
  </div>
  <div class="boxGray">

    <div id="newHelper">
      <g:link class="buttonBlue" action="create" params="[name:entity.name]">Neue Beurteilung erstellen</g:link>
    </div>

    <p>Es gibt insgesamt ${evaluationInstanceList.size()} Beurteilungen für ${entity.profile.fullName}.</p>

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
        <g:link class="helperButton" action="edit" id="${evaluationInstance.id}" params="[name:entity.name]">bearbeiten</g:link>
      </div>
    </g:each>
    </ul>
  
</div>
</body>
