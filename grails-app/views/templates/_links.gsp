<div class="zusatz">
  <h5>Verlinkungen</h5>
  <div class="linkstabs">

    <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Einrichtung','Betreuter','Partner','Erziehungsberechtigter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'groupActivities']" before="showspinner('#linkscontent')">Aktivitätsblöcke</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Einrichtung','Betreuter','Partner','Erziehungsberechtigter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'projects']" before="showspinner('#linkscontent')">Projekte</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Einrichtung','Betreuter','Pädagoge']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'activities']" before="showspinner('#linkscontent')">Themenraumaktivitäten</g:remoteLink></span>
    </app:accessCheck>

    <app:accessCheck entity="${entity}" roles="[]" types="['Erziehungsberechtigter','Betreuter','Kind']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'families']" before="showspinner('#linkscontent')">Familien</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Einrichtung','Partner']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'colonies']" before="showspinner('#linkscontent')">Gemeinden</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Betreuter','Pädagoge']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'facilities']" before="showspinner('#linkscontent')">Einrichtungen</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Betreuter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'clientgroups']" before="showspinner('#linkscontent')">Betreutengruppen</g:remoteLink></span>
    </app:accessCheck>
    <app:accessCheck entity="${entity}" roles="[]" types="['Partner']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'partnergroups']" before="showspinner('#linkscontent')">Sponsorennetzwerke</g:remoteLink></span>
    </app:accessCheck>

  </div>
  <div id="linkscontent" style="padding: 5px;">
  </div>
</div>