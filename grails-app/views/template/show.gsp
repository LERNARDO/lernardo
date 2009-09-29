<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${template.name}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="profile-group" style="width:200px;">Aktivitätsvorlage - Details</div>
    <div class="profile-box">
      <table width="100%">
        <tr class="separator"><td class="bold titles2 bezeichnung">Name:</td><td class="bezeichnung">${template.name}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Zuordnung:</td><td class="bezeichnung">${template.zuordnung}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Beschreibung:</td><td class="bezeichnung">${template.beschreibung}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Dauer:</td><td class="bezeichnung">${template.dauer}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Sozialform:</td><td class="bezeichnung">${template.sozialform}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Materialien:</td><td class="bezeichnung">${template.materialien}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Lernen lernen:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.ll.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Bewegung & Ernährung:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.be.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Persönliche Kompetenz:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.pk.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Soziale & emotionale Intelligenz:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.si.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Handwerk & Kunst:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.hk.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Teilleistungstraining:</td><td class="bezeichnung">
        <g:each in="${ (0..<template.tlt.toInteger()) }"><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}"/></g:each>
        </td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Qualifikationen:</td><td class="bezeichnung">${template.qualifikationen}</td></tr>
        <tr class="separator"><td class="bold titles2 bezeichnung">Teamgröße:</td><td class="bezeichnung">${template.anzahlPaedagogen}</td></tr>
      </table>
    </div>

    <div id="newActivity">
      <g:link controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>
    </div>
  
    <div id="comments-block">
      <h1>Kommentare</h1>
      <div class="single-entry">

        <div class="user-entry">
          <div class="user-pic">
            <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" align="left" /></a>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><a href="#">Vorname Nachname</a></div>
            <div class="info">
              <div class="time">am Montag, 16:30h</div>
              <div class="actions"><a href="#">Kommentieren</a></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Eintrag mit Bild, etc...<br />
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.<br /><br />
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" /></a>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><a href="#">Vorname Nachname</a></div>
                <div class="time">am Dienstag, 16:39h</div>
              </div>
              <div class="comment">
                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" /></a>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><a href="#">Vorname Nachname</a></div>
                <div class="time">am Dienstag, 16:39h</div>
              </div>
              <div class="comment">
                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>
      </div>
      <!-- END single-entry -->

      <div class="single-entry">
        <div class="user-entry">
          <div class="user-pic">
            <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" align="left" /></a>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><a href="#">Vorname Nachname</a></div>
            <div class="info">
              <div class="time">am Montag, 16:30h</div>
              <div class="actions"><a href="#">Kommentieren</a></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Eintrag mit Bild, etc...<br />
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.<br /><br />
          </div>
        </div>

        <div class="user-entry">
          <div class="user-pic">
            <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" align="left" /></a>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><a href="#">Vorname Nachname</a></div>
            <div class="info">
              <div class="time">am Montag, 16:30h</div>
              <div class="actions"><a href="#">Kommentieren</a></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Eintrag mit Bild, etc...<br />
            Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.<br /><br />
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <a href="#"><img src="${resource(dir:'images/avatar', file:'lernardo.jpg')}" width="50" height="60" /></a>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><a href="#">Vorname Nachname</a></div>
                <div class="time">am Dienstag, 16:39h</div>
              </div>
              <div class="comment">
                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>

      </div>
      <!-- END single-entry -->

      <div class="comments-actions">
        <a href="#">Neuen Kommentar abgeben</a>
      </div>
    </div>

  </body>

</html>