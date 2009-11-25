<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
      <div class="yui-b" id="admin-navigation">
        <div id="body-list">
          <h2>Adminbereich</h2>
          <ul>
            <li><g:link controller="profile" action="list">Liste der Profile anzeigen</g:link></li>
            <li><g:link controller="template" action="list">Liste der Aktivitätsvorlagen anzeigen</g:link></li>
            <li><g:link controller="activity" action="list">Liste der Aktivitäten anzeigen</g:link></li>
            <li><g:link controller="profile" action="attendance">Anwesenheits-/Essensliste anzeigen</g:link></li>
            <li><g:link controller="profile" action="createOperator">Betreiber anlegen</g:link></li>
            <li><g:link controller="profile" action="createPaed">Pädagoge anlegen</g:link></li>
          </ul>
        </div>
      </div>
      <div id="yui-main">
        <div class="yui-b">
          <div id="admin-content">
            <p>Info:</p>
            <ul>
              <li>Betreiber und Pädagogen können nur als Admin angelegt werden.</li>
              <li>Horte werden über das Profil eines Betreibers angelegt.</li>
              <li>Betreute werden über das Profil eines Hortes angelegt.</li>
            </ul>
           </div>
        </div>
      </div>
  </body>