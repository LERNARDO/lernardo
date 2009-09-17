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

          <div class="profile-box">
            <table width="250" align="center">
              <tr><th class="rang"><p>${fullName} - ${role}</p></th></tr>
              <tr>
                <td class="profile-pic"><img src="" /></td>
              </tr>
            </table>
          </div><!--Bild&Rang-->

          <div class="profile-group">Kommunikation</div>
          <div class="profile-box">
            <ul>
              <li class="profile-profil"><a href="#"><strong>Profil ansehen</strong></a></li>
              <li class="profile-nachricht"><a href="#">Nachricht schreiben</a></li>
              <li class="profile-telefon"><a href="#">SMS senden</a></li>
              <li class="profile-leistung"><a href="#">Leistungsfortschritt</a></li>
              <li class="profile-netzwerk"><a href="#">Zu Netzwerk hinzufügen</a></li>
            </ul>
          </div><!--persoenlich-->

          <div class="profile-group">Netzwerk</div>
          <div class="profile-box">
            <ul>
              <li><a href="/lernardoV2/prf/alpha">Verein Alpha - Frauen für die Zukunft</a> (Betreiber)</li>
              <li><a href="/lernardoV2/prf/lernardo">LERNARDO Lernen - Wachsen</a> (Betreiber)</li>
            </ul>
          </div><!--netzwerk-->
        </div>
        
        <div id="yui-main">
          <div class="yui-b" id="profile-content">
            <table width="100%">
              <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${fullName}</td></tr>
              <tr><td class="bold titles bezeichnung">PLZ:</td><td class="bezeichnung">${plz}</td></tr>
              <tr><td class="bold titles bezeichnung">Ort:</td><td class="bezeichnung">${ort}</td></tr>
              <tr><td class="bold titles bezeichnung">Straße:</td><td class="bezeichnung">${strasse}</td></tr>
              <tr><td class="bold titles bezeichnung">Gemeinnützigkeit:</td><td class="bezeichnung">${gemeinnutzigkeit}</td></tr>
              <tr><td class="bold titles bezeichnung">Ansprechperson:</td><td class="bezeichnung">${ansprechperson}</td></tr>
            </table>

            <g:form>
              <input type="hidden" name="id" value="${name}" />
              <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
            </g:form>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>