<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil - Pädagoge</title>
  </head>
  <body>
    <div id="doc4" class="yui-t3">
      <div id="bd">

        <div class="yui-b" id="profile-navigation">

          <div class="profile-box">
            <table align="center">
              <tr><th class="rang"><p>${firstName} ${lastName} - ${role}</p></th></tr>
              <tr><td class="profile-pic"><img src="${image}" width="150" height="150"/></td></tr>
            </table>
          </div>

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <li class="profile-profil"><a href="#"><strong>Profil ansehen</strong></a></li>
              <li class="profile-nachricht"><a href="#">Nachricht schreiben</a></li>
              <li class="profile-telefon"><a href="#">SMS senden</a></li>
              <li class="profile-netzwerk"><a href="#">Zu Netzwerk hinzufügen</a></li>
            </ul>
          </div>

          <div class="profile-group">Netzwerk</div>
          <div class="profile-box">
            <ul>
              <g:each in="${friends}" var="friend">
                <li><a href="/lernardoV2/prf/${friend.key}">${friend.key[0].toUpperCase() + friend.key.substring(1)}</a> (${friend.value})</li>
              </g:each>
            </ul>
          </div>
        </div>

        <div id="yui-main">
          <div class="yui-b">
            <div id="profile-content">
              <table width="100%">
                <tr><td class="bold titles bezeichnung">Titel:</td><td class="bezeichnung">${title}</td></tr>
                <tr><td class="bold titles bezeichnung">Vorname:</td><td class="bezeichnung">${firstName}</td></tr>
                <tr><td class="bold titles bezeichnung">Nachname:</td><td class="bezeichnung">${lastName}</td></tr>
                <tr><td class="bold titles bezeichnung">Geburtstag:</td><td class="bezeichnung">${birthDate}</td></tr>
                <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
                <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
                <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
                <tr><td class="bold titles bezeichnung">E-Mail:</td><td class="bezeichnung">${mail}</td></tr>
                <tr><td class="bold titles bezeichnung">Telefon:</td><td class="bezeichnung">${tel}</td></tr>
              </table>
              %{--<g:form>
                <input type="hidden" name="id" value="${name}" />
                <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
              </g:form>--}%
            </div>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>