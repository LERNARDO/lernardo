<head>
  <meta name="layout" content="planning"/>
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

    <g:render template="/templates/groupActivityNavigation" model="[entity: group]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupActivityProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${group.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${group}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${group.id}"><g:message code="comments"/> (${group.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: group]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${group.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="groupActivityTemplate"/>:</td>
          <td class="two">
            <g:if test="${template}">
              <g:link controller="groupActivityTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName?.decodeHTML()}</g:link>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="template.notAvailable"/></span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivity.profile.realDuration"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="date"/>:</td>
          <td class="two"><g:formatDate date="${group?.profile?.date}" format="dd. MMMM yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivity.profile.educationalObjective"/>:</td>
          <td class="two">
            <g:if test="${group.profile.educationalObjective}">
              <g:message code="goal.${group.profile.educationalObjective}"/>
            </g:if>
            <g:else>
              <span class="italic"><g:message code="none"/></span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivity.profile.educationalObjectiveText"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

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

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="activities"/></h5>
        <div class="zusatz-show">
          <g:if test="${templates}">
            <p>
              <span class="bold"><g:message code="calculatedTotalDuration"/>:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}">- <span class="red"><g:message code="groupActivityTemplate.profile.durationerror"/></span></g:if>
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
        <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkoperator="true"><a onclick="toggle('#labels');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="labels" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'groupActivityProfile', action:'addLabel', id:group.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            %{--<div class="clear"></div>--}%
            <g:submitButton name="button" value="${message(code:'add')}"/>
            %{--<div class="clear"></div>--}%
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="labels2">
          <g:render template="labels" model="[group: group]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="themes"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#themes');
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
          <g:render template="themes" model="[themes: themes, group: group]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="facility"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#facilities');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="facilities" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'groupActivityProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2');" after="${remoteFunction(action: 'refreshplannableresources', update: 'plannableresources', id: group.id)}">
            <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="facilities2">
          <g:render template="facilities" model="[facilities: facilities, group: group]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="educators"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#educators');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="educators" style="display:none">
          <g:message code="search"/>:<br/>
          <g:remoteField name="remoteField" size="40" update="educatorresults" action="remoteEducators" id="${group.id}" before="showspinner('#educatorresults')"/>
          <div id="educatorresults"></div>
        </div>
        <div class="zusatz-show" id="educators2">
          <g:render template="educators" model="[educators: educators]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="substitute"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#substitutes');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="substitutes" style="display:none">
          <g:message code="search"/>:<br/>
          <g:remoteField name="remoteField" size="40" update="substituteresults" action="remoteSubstitutes" id="${group.id}" before="showspinner('#substituteresults')"/>
          <div id="substituteresults"></div>
        </div>
        <div class="zusatz-show" id="substitutes2">
          <g:render template="substitutes" model="[substitutes: substitutes]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="clients"/> (${clients.size()}) <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#clients');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="clients" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${group.id}" before="showspinner('#remoteClients');"/>
          <div id="remoteClients"></div>

        </div>
        <div class="zusatz-show" id="clients2">
          <g:render template="clients" model="[clients: clients]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="parents"/> (${parents.size()}) <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#parents');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="parents" style="display:none">
          <g:formRemote name="formRemote4" url="[controller:'groupActivityProfile', action:'addParent', id: group.id]" update="parents2" before="showspinner('#parents2');" after="toggle('#parents');">
            <div id="parentselect">
              <g:render template="parentselect" model="[allParents: allParents, group: group]"/>
            </div>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="parents2">
          <g:render template="parents" model="[parents: parents]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="partners"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#partners');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="partners" style="display:none">
          <g:formRemote name="formRemote5" url="[controller:'groupActivityProfile', action:'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2');" after="toggle('#partners');">
            <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="partners2">
          <g:render template="partners" model="[partners: partners]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="resources.planned"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#resources');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>

        <div class="zusatz-add" id="resources" style="display:none">
          <span class="bold"><g:message code="resources.required"/></span>
          <g:if test="${requiredResources}">
            <ul style="margin: 5px 5px 0 5px;">
              <g:each in="${requiredResources}" var="requiredResource">
                <li style="list-style-type: circle">${requiredResource.amount}x "${requiredResource.name}" - ${requiredResource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic" style="margin: 5px;"><g:message code="resources.noneRequired"/></div>
          </g:else>

          <span class="bold"><g:message code="resource.profile"/></span> %{--<g:remoteLink update="plannableresources" action="refreshplannableresources" id="${group.id}"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink>--}%
          <div id="plannableresources">
            <g:render template="plannableresources" model="[plannableResources: plannableResources, group: group]"/>
          </div>
        </div>
        <div class="zusatz-show" id="resources2">
          <g:render template="resources" model="[resources: resources, group: group]"/>
        </div>
      </div>

    </div>

  </div>
</div>

</body>