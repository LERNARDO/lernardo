<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivity"/> - ${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivity"/> - ${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: group]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${group.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table style="width: 100%">

        <tr>
          <td colspan="3" valign="top" class="name">
            <g:if test="${template}">
              <g:message code="groupActivityTemplate"/>: <g:link controller="groupActivityTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName?.decodeHTML()}</g:link>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="template.notAvailable"/></span>
            </g:else>
          </td>
        </tr>

        <tr>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.realDuration"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.date"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
          <td valign="top" class="value-show"><g:formatDate date="${group?.profile?.date}" format="dd. MMMM yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr>
          <td valign="top" class="name-show"><g:message code="groupActivity.profile.educationalObjective"/>:</td>
          <td colspan="2" valign="top" class="name-show"><g:message code="groupActivity.profile.educationalObjectiveText"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <g:if test="${group.profile.educationalObjective}">
              <g:message code="goal.${group.profile.educationalObjective}"/>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="none"/></span>
            </g:else>
          </td>
          <td colspan="2" valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

        <tr>
          <td class="name-show"><g:message code="groupActivity.profile.description"/>:</td>
        </tr>
        <tr>
          <td colspan="3" class="value-show">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

      </table>
    </div>

    <div class="buttons">
      <g:form id="${group.id}" params="[entity: group?.id]">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: group.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGreen" action="createpdf" value="${message(code: 'createPDF')}" /> <g:checkBox name="withTemplates" value=""/> mit Aktivitätsvorlagen</div>
        <div class="spacer"></div>
      </g:form>
    </div>

    <script type="text/javascript">
      $(document).ready(function() {
        $('.hover').each(function() {
          $(this).qtip({
            content: {
              text: 'Loading...',
              ajax: {
                url: '${grailsApplication.config.grails.serverURL}/groupActivityTemplateProfile/templateHover',
                type: 'GET',
                data: {id : $(this).attr('data-idd')}
              }
            }
          });
        });
      });
    </script>

    <div class="zusatz">
      <h5><g:message code="activities"/></h5>
      <div class="zusatz-show">
        <g:if test="${templates}">
          <p>
            <span class="bold"><g:message code="calculatedTotalDuration"/>:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}">- %{--<img src="${g.resource(dir: 'images/icons', file: 'icon_warning.png')}" alt="Achtung" align="top"/>--}%<span class="red"><g:message code="groupActivityTemplate.profile.durationerror"/></span></g:if>
          </p>
          <ul>
            <g:each in="${templates}" var="template">
              <li><g:link class="hover" controller="templateProfile" action="show" data-idd="${template.id}" id="${template.id}">${template.profile.fullName}</g:link> <span class="gray">(${template.profile.duration} min)</span></li>
            </g:each>
          </ul>
        </g:if>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="themes"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#themes');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Zu Thema zuordnen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="themes" style="display:none">
        <g:if test="${allThemes}">
          <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addTheme', id: group.id]" update="themes2" before="showspinner('#themes2');"  after="toggle('#themes');">
            <g:select name="theme" from="${allThemes}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
        </g:if>
        <g:else>
          <g:message code="project.noThemes"/>
        </g:else>
      </div>
      <div class="zusatz-show" id="themes2">
        <g:render template="themes" model="[themes: themes, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facility"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#facilities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2');" after="${remoteFunction(action: 'refreshplannableresources', update: 'plannableresources', id: group.id)}">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educators"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#educators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="educators" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addEducator', id: group.id]" update="educators2" before="showspinner('#educators2');" after="toggle('#educators');">
          <div id="educatorselect">
            <g:render template="educatorselect" model="[allEducators: allEducators, group: group]"/>
          </div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="substitute"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#substitutes');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="substitutes" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addSubstitute', id: group.id]" update="substitutes2" before="showspinner('#substitutes2');" after="toggle('#substitutes');">
          <g:select name="substitute" from="${allSubstitutes}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="substitutes2">
        <g:render template="substitutes" model="[substitutes: substitutes, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="clients"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#clients');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${group.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="parents"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#parents');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="parents" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupActivityProfile', action:'addParent', id: group.id]" update="parents2" before="showspinner('#parents2');" after="toggle('#parents');">
          <div id="parentselect">
            <g:render template="parentselect" model="[allParents: allParents, group: group]"/>
          </div>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="parents2">
        <g:render template="parents" model="[parents: parents, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partners"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#partners');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupActivityProfile', action:'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2');" after="toggle('#partners');">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Eingeplante Ressourcen <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>

      <div class="zusatz-add" id="resources" style="display:none">
        <b><g:message code="resources.required"/></b>
        <g:if test="${requiredResources}">
          <ul style="margin-left: 5px">
            <g:each in="${requiredResources}" var="requiredResource">
              <li style="list-style-type: circle">${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
            </g:each>
          </ul>
        </g:if>
        <g:else>
          <div class="gray" style="margin-bottom: 5px">Keine benötigten Ressourcen!</div>
        </g:else>

        <b><g:message code="resource.profile"/></b> <g:remoteLink update="plannableresources" action="refreshplannableresources" id="${group.id}"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink>
        <div id="plannableresources">
          <g:render template="plannableresources" model="[plannableResources: plannableResources, group: group]"/>
        </div>
      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, entity: currentEntity, group: group]"/>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: group]"/>
</erp:accessCheck>

</body>