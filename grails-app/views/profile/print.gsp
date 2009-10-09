<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="print" />
    <title>Sample title</title>
  </head>
  <body>
    <div id="container">
    <h1>Hort XYZ</h1>
    <p>Anwesenheits- und Essensliste</p>
    <p>Woche 31</p>
    
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
            <td>${profileInstance.value.fullName}></td>
            <td class="col">${profileInstance.value.tel}</td>
            <td class="col">[ ]</td>
            <td class="col">[ ]</td>
        </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </body>
</html>
