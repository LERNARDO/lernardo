<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Anwesenheits-/Essensliste</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste der Profile</h2>
      <p>${profileCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          <label>Auswahl
            <select name="week">
              <option value="1" selected="selected">Woche 1</option>
              <option value="2">Woche 2</option>
              <option value="3">Woche 3</option>
              <option value="4">Woche 4</option>
              <option value="5">Woche 5</option>
            </select>                  
          </label>
          <g:submitButton name="list" value="OK" />
        </g:form>
      </div>

      <table id="profile-list">
        <thead>
          <tr>
        <g:sortableColumn property="fullName" title="Name" />
        <g:sortableColumn property="tel" title="Telefon" />
        <g:sortableColumn property="anwesend" title="Anwesend" />
        <g:sortableColumn property="essen" title="Essen" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="row-${profileInstance.value.type}">
            <td><g:link controller="profile" action="show" params="[name:profileInstance.value.name]" >${profileInstance.value.fullName}</g:link></td>
            <td class="col">${profileInstance.value.tel}</td>
            <td class="col">[ ]</td>  
            <td class="col">[ ]</td>
        </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:set var="pType" value="client" />
        <g:paginate action="list"
                    params="[profileType:pType]"
                    total="${profileCount}" />
      </div>

      <g:submitButton name="print" value="Drucken" />

    </div>
  </body>
</html>