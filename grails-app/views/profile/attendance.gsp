<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Anwesenheits-/Essensliste</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Anwesenheits-/Essensliste</h2>
      <p>${entityCount} Profile gefunden</p>

      <g:pdfForm controller="profile" action="print" method="post" filename="Anwesenheitsliste.pdf">
                                        Hort:<g:select name="hort" from="${['Löwenzahn', 'Kaumberg']}" value="Kaumberg" />
                                        Monat:<g:select name="monat" from="${1..12}" value="1" />
        <g:submitButton name="printPdf" value="PDF erzeugen" icon="true"/>
      </g:pdfForm>

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
        <g:each status="i" in="${entityList}" var="entity">
          <tr class="row-${entity.type}">
            <td><g:link controller="profile" action="show" params="[name:entity.name]" >${entity.profile.fullName}</g:link></td>
          <td class="col">${entity.profile.tel}</td>
          <td class="col">14</td>
          <td class="col">14</td>
          </tr>
        </g:each>
        <tr>
          <td>Gesamt</td>
          <td></td>
          <td>84</td>
          <td>84 * 3 = €252</td>
        </tr>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate action="list"
                    params="[entityType:'Client']"
                    total="${entityCount}" />
      </div>

    </div>
  </body>
</html>