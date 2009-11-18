<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <meta name="layout" content="print" />
    <title>Sample title</title>
    <style>
      #container {
        border: 1px solid #ccc;
        padding: 5px;
        font-family: verdana,arial,helvetica,sans-serif;
        font-size: 12px;
      }
      #container {
        width: 100%;
        height: 200px;
        background: #eee;
        border: #ddd;
      }

      #notizen {
        width: 100%;
        height: 500px;
        background: #eee;
        border: #ddd;
      }

      .notizen {
        border:1px dotted #fff;
      }

      #container td {
        border-bottom: 1px dashed #ccc;
        width: 200px;
      }
      #container img {
        width: 150px;
        height: 150px;
        background: #000;
      }
    </style>
  </head>
  <body>
    <div id="container">

      <img src="${g.resource(dir:'images/avatar', file:image)}" alt="Hort ${pdf.hort}"/>

      <h1>Hort ${pdf.hort}</h1>
      <p>Anwesenheits- und Essensliste für Monat ${pdf.monat}</p>
      <p>Gedruckt von <ub:entityName format="full" /> <br /> <cu:timestamp />
      </p>
      <table id="profile-list">
        <thead>
          <tr>
            <th>Name</th>
            <th>Telefon</th>
            <th>Anwesend</th>
            <th>Essen</th>
          </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr>
            <td>${profileInstance.value.fullName}</td>
            <td>${profileInstance.value.tel}</td>
            <td>14</td>
            <td>14</td>
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

      <p><strong>Notizen:</strong></p>
      <div id="notizen">
        <table width="680" height="500" style="notizen" cellspacing="0" cellpadding="0">
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
          <tr><td height="40"></td></tr>
        </table>
      </div>
    </div>
  </body>
</html>
