<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil - Betreiber</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <div class="profile-box-betreiber">
            <table width="250" align="center">
              <tr><th class="rang"><h1>${fullName} - ${role}</h1></th></tr>
              <tr><td class="profile-pic"><img src="${image}" width="150" height="150"/></td></tr>
            </table>
          </div>

          <div class="profile-group-betreiber">Kommunikation</div>
          <div class="profile-box-betreiber">
            <ul>
              <li class="profile-profil"><a href="#"><strong>Profil ansehen</strong></a></li>
              <li class="profile-nachricht"><a href="#">Nachricht schreiben</a></li>
              <li class="profile-netzwerk"><a href="#">Zu Netzwerk hinzufügen</a></li>
            </ul>
          </div>

          <div class="profile-group-betreiber">Netzwerk</div>
          <div class="profile-box-betreiber">
            <ul>
              <g:each in="${friends}" var="friend">
                <li><a href="/lernardoV2/prf/${friend.key}">${friend.key[0].toUpperCase() + friend.key.substring(1)}</a> (${friend.value})</li>
              </g:each>
            </ul>
          </div>
        </div>

        <div id="yui-main">
          <div class="yui-b">
            <div id="profile-content-betreiber">
              <table width="100%">
                <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${fullName}</td></tr>
                <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
                <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
                <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
                <tr><td class="bold titles bezeichnung">Gemeinnützigkeit:</td><td class="bezeichnung">${gemeinnutzigkeit}</td></tr>
                <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${ansprechperson}</td></tr>
              </table>
              %{--<g:form action="edit">
                <input name="name" type="hidden" value="${name}" />
                <span class="button"><g:actionSubmit name="edit" action="edit" value="Bearbeiten" /></span>
              </g:form>--}%
            </div>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>