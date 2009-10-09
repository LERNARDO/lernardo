<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Anwesenheits-/Essensliste</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Anwesenheits-/Essensliste</h2>
      <p>${profileCount} Profile gefunden</p>

      <g:pdfForm controller="profile" action="print" method="post" filename="Anwesenheitsliste.pdf">
                                        Hort:<g:select name="hort" from="${['Löwenzahn', 'Kaumberg']}" value="Kaumberg" />
                                        Woche:<g:select name="woche" from="${1..52}" value="1" />
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
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="row-${profileInstance.value.type}">
            <td><g:link controller="profile" action="show" params="[name:profileInstance.value.name]" >${profileInstance.value.fullName}</g:link></td>
          <td class="col">${profileInstance.value.tel}</td>
          <td class="col">O</td>
          <td class="col">O</td>
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

    </div>
  </body>
</html>