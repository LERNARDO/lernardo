<ul>
  <g:each in="${evaluations}" status="i" var="evaluation">
    <div class="leistung-item">
      <table cellpadding="2">
        <tr>
          <td class="bold vtop">Betreuter:</td>
          <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
        </tr>
        <tr>
          <td class="bold vtop">Datum:</td>
          <td><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy"/></td>
        </tr>
        <tr>
          <td class="bold vtop">Beschreibung:</td>
          <td>${evaluation.description.decodeHTML()}</td>
        </tr>
        <tr>
          <td class="bold vtop">Maßnahme:</td>
          <td>${evaluation.method.decodeHTML()}</td>
        </tr>
        <tr>
          <td class="strong vtop">Von:</td>
          <td>${evaluation.writer.profile.fullName}</td>
        </tr>
      </table>
    </div>
  </g:each>
</ul>

<div class="paginateButtons">
  <util:remotePaginate action="showByEducator" total="${totalEvaluations}" update="remoteEvaluations" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}" params="[value: value]"/>
</div>