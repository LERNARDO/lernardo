<div class="zusatz">
  <h5><g:message code="links"/></h5>
  <div class="linkstabs">

    <erp:accessCheck entity="${entity}" types="['Pädagoge','Einrichtung','Betreuter','Partner','Erziehungsberechtigter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'groupActivities']" before="showspinner('#linkscontent')"><g:message code="groupActivities"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Pädagoge','Einrichtung','Betreuter','Partner','Erziehungsberechtigter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'projects']" before="showspinner('#linkscontent')"><g:message code="projects"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Einrichtung','Betreuter','Pädagoge']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'activities']" before="showspinner('#linkscontent')"><g:message code="activityInstances"/></g:remoteLink></span>
    </erp:accessCheck>

    <erp:accessCheck entity="${entity}" types="['Erziehungsberechtigter','Betreuter','Kind']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'families']" before="showspinner('#linkscontent')"><g:message code="groupFamilies"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Einrichtung','Partner']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'colonies']" before="showspinner('#linkscontent')"><g:message code="groupColonies"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Betreuter','Pädagoge']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'facilities']" before="showspinner('#linkscontent')"><g:message code="facilities"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Betreuter']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'clientgroups']" before="showspinner('#linkscontent')"><g:message code="groupClients"/></g:remoteLink></span>
    </erp:accessCheck>
    <erp:accessCheck entity="${entity}" types="['Partner']">
      <span class="linktab"><g:remoteLink update="linkscontent" controller="app" action="updatelinks" id="${entity.id}" params="[type: 'partnergroups']" before="showspinner('#linkscontent')"><g:message code="groupPartners"/></g:remoteLink></span>
    </erp:accessCheck>

  </div>
  <div id="linkscontent" style="padding: 5px;">
  </div>
</div>