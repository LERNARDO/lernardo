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
            <g:link action="show" controller="profile" params="[name:'regina']"><img src="${resource(dir:'images/avatar', file:'regina_toncourt.jpg')}" width="50" height="60" align="left" /></g:link>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><g:link action="show" controller="profile" params="[name:'regina']">Regina Toncourt</g:link></div>
            <div class="info">
              <div class="time">am Montag - 28. September 2009 , 16:30h</div>
              <div class="actions"><a href="#">Kommentieren</a></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Sehr nette Aktivität! <br />
            Die Beschreibung könnte aber noch etwas genauer ausgeführt werden.
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'patrizia']"><img src="${resource(dir:'images/avatar', file:'patrizia_rosenkranz.jpg')}" width="50" height="60" /></g:link>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><g:link action="show" controller="profile" params="[name:'patrizia']">Patrizia Rosenkranz</g:link></div>
                <div class="time">am Dienstag - 29. September 2009, 16:39h</div>
              </div>
              <div class="comment">
                Ja schon, finde ich auch!
              </div>
            </div>
            <div class="clear"></div>
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'martin']"><img src="${resource(dir:'images/avatar', file:'martin_golja.jpg')}" width="50" height="60" /></g:link>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><g:link action="show" controller="profile" params="[name:'martin']">Martin Golja</g:link></div>
                <div class="time">am Dienstag - 29. September 2009, 17:00h</div>
              </div>
              <div class="comment">
              So l&auml;sst es aber mehr Platz für individuelle Interpretation. Finde ich nicht schlecht!
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
            <g:link action="show" controller="profile" params="[name:'johannes']"><img src="${resource(dir:'images/avatar', file:'johannes_zeitelberger.jpg')}" width="50" height="60" align="left" /></g:link>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><g:link action="show" controller="profile" params="[name:'johannes']">Johannes Zeitelberger</g:link></div>
            <div class="info">
              <div class="time">am Dienstag - 29. September 2009 , 17:30h</div>
              <div class="actions"><a href="#">Kommentieren</a></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Das Rating mit den Sternen ist sehr n&uuml;tzlich. Da sieht man gleich auf einem Blick die Zuordnung.
          </div>
        </div>
      </div>
      <!-- END single-entry -->
      
      <div class="single-entry">
        <div class="user-entry">
          <div class="user-pic">
            <g:link action="show" controller="profile" params="[name:'johannes']"><img src="${resource(dir:'images/avatar', file:'johannes_zeitelberger.jpg')}" width="50" height="60" align="left" /></g:link>
          </div>
          <div class="community-entry-infobar">
            <div class="name"><g:link action="show" controller="profile" params="[name:'johannes']">Johannes Zeitelberger</g:link></div>
            <div class="info">
              <div class="time">am Mittwoch - 30. September 2009, 08:30h</div>
              <div class="actions"><g:link action="show" controller="profile" params="[name:'johannes']">Kommentieren</g:link></div>
            </div>
          </div>
          <div class="clear"></div>
          <div class="entry-content">
            Das Kommentarsystem finde ich auch sehr gelungen!
          </div>
        </div>

        <div class="community-entry-comments">
          <div class="entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'alexander']"><img src="${resource(dir:'images/avatar', file:'alexander_zeilinger.jpg')}" width="50" height="60" /></g:link>
            </div>
            <div class="user-comment">
              <div class="info">
                <div class="user-name"><g:link action="show" controller="profile" params="[name:'alexander']">Alexander Zeillinger</g:link></div>
                <div class="time">am Mittwoch - 30. September 2009, 08:45h</div>
              </div>
              <div class="comment">
              Haben ja auch wir gemacht!
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