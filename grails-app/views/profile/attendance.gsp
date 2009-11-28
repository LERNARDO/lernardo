<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Anwesenheits-/Essensliste</title>
    <script type="text/javascript">
      function anyCheck(form) {
      var total = 0;
      var max = form.anwesend.length;
      for (var ida = 0; ida < max; ida++) {
      if (eval("document.clients.anwesend[" + ida + "].checked") == true) {
          total += 1;
         }
      }
      document.getElementById('sumAnwesenheit').innerHTML=total;

      total = 0;
      max = form.essen.length;
      for (var idx = 0; idx < max; idx++) {
      if (eval("document.clients.essen[" + idx + "].checked") == true) {
          total += 1;
         }
      }
      document.getElementById('sumEssen').innerHTML='€ '+total*3;
      //alert("You selected " + total + " boxes.");
      }
    </script>
  </head>
  <body>
    <div id="body-list">
      <h2>Anwesenheits-/Essensliste</h2>
      <p>${entityCount} Profile gefunden</p>

      <g:pdfForm controller="profile" action="print" method="post" filename="Anwesenheitsliste.pdf">
        Hort:<g:select name="hort" from="${['Löwenzahn', 'Kaumberg']}" value="Kaumberg" /><br/>
        Datum:<g:datePicker name="date" value="${date}" precision="day" years="${2009..2020}"/>
              %{--<g:select name="monat" from="${1..12}" value="1" />--}%
        <g:submitButton name="printPdf" value="PDF erzeugen" icon="true"/>
      </g:pdfForm>

      <hr/>
      <p>Anwesenheiten für <g:formatDate date="${date}" format="EEEE, dd. MM. yyyy"/></p>
      <p>Täglicher Essenbeitrag: €3.-</p>

      <form method="post" name="clients">

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
              <td class="col"><input type="checkbox" name="anwesend"></td>
              <td class="col"><input type="checkbox" name="essen"></td>
              </tr>
            </g:each>

          <tr>
            <td>Gesamt</td>
            <td></td>
            <td id="sumAnwesenheit">0</td>
            <td id="sumEssen">0</td>
          </tr>
          </tbody>
        </table>

        <input type="button" value="Summe berechnen" onClick="anyCheck(this.form)">
      </form>
      <div class="paginateButtons">
        <g:paginate action="list"
                    params="[entityType:'Client']"
                    total="${entityCount}" />
      </div>

    </div>
  </body>
</html>