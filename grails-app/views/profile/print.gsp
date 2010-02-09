<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <meta name="layout" content="print" />
    <title>Lernardo | Anwesenheits- und Essensliste</title>
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
        height: 400px;
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
      .boxEmpty {
        height:10px;
        width:10px;
        border: 1px solid #000;
      }
      .boxFull {
        height:10px;
        width:10px;
        border: 1px solid #000;
        background: #ccc;
      }
    </style>
  </head>
  <body>
    <div id="container">

      <img src="${g.resource(dir:'images/avatar', file:image)}" alt="Hort ${pdf.hort}"/>

      <h1>${currentEntity.profile.fullName}</h1>
      <p>Anwesenheits- und Essensliste vom <g:formatDate date="${date}" format="EEEE, 'den' dd. MM. yyyy"/></p>
      <p>Täglicher Essensbeitrag: €${currentEntity.profile.foodCosts}.-</p>
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
        <g:each status="i" in="${entityList}" var="entity">
          <tr>
            <td>${entity.profile.fullName}</td>
            <td>${entity.profile.tel}</td>
            <td><g:if test="${attend[i].didAttend}"><div class="boxFull"></div></g:if><g:else><div class="boxEmpty"></div></g:else></td>
            <td><g:if test="${attend[i].didEat}"><div class="boxFull"></div></g:if><g:else><div class="boxEmpty"></div></g:else></td>
          </tr>
        </g:each>
          <tr style="font-weight: bold">
            <td>Gesamt</td>
            <td></td>
            <td id="sumAnwesenheit">${sumAttend}</td>
            <td id="sumEssen">€ ${sumEat * currentEntity.profile.foodCosts}</td>
          </tr>
        </tbody>
      </table>

      <p><strong>Notizen:</strong></p>
      <div id="notizen">
        <table width="680" style="notizen" cellspacing="0" cellpadding="0">
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
