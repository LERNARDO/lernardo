<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">
        <div class="yui-b" id="admin-navigation">
          <div id="body-list">
            <h2>Adminbereich</h2>
            <ul>
              <li><g:link controller="profile" action="list">Liste der Profile anzeigen</g:link></li>
              <li><g:link controller="template" action="list">Liste der Aktivitätsvorlagen anzeigen</g:link></li>
              <li><g:link controller="activity" action="list">Liste der Aktivitäten anzeigen</g:link></li>
              <li><g:link controller="profile" action="attendance">Anwesenheits-/Essensliste anzeigen</g:link></li>
              <li><g:link controller="profile" action="create">Profil anlegen</g:link></li>
            </ul>
          </div>
        </div>
        <div id="yui-main">
          <div class="yui-b">
            <div id="admin-content">
              <p>Links kann man zu den einzelnen Bereichen navigieren</p>
             </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>