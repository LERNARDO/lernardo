<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.status"/></td>
        </tr>

        <tr>
          <td width="500px" valign="top" class="value-show">
            <g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td width="170px" valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.realDuration')} min
          </td>
          <td valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.status').decodeHTML()}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="3" valign="top" class="name"><g:message code="groupActivityTemplate.profile.description"/></td>
        </tr>

        <tr>
          <td colspan="3" height="60" valign="top" class="value-show-block">
            ${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
        </tr>

      </table>
    </div>

    <div class="buttons">
      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGreen" action="create" id="${group.id}">Vorlage duplizieren</g:link>

        %{-- and only when it is done --}%
          <g:if test="${group.profile.status == 'fertig'}">
            <g:link class="buttonGreen" controller="groupActivityProfile" action="create" id="${group.id}">Aktivitätsblock instanzieren</g:link>
          </g:if>
      </app:hasRoleOrType>
      <g:link class="buttonGray" action="list">Zurück</g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5>Aktivitätsvorlagen <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#templates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsvorlage hinzufügen"/></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="templates" style="display:none">
        <p>Die Aktivitätsvorlagen können nach folgenden Merkmalen eingegrenzt werden: (max. 30 Treffer werden angezeigt!)</p>
        <g:formRemote name="formRemote0" url="[controller:'groupActivityTemplateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect')">

          <table>
            <tr>
              <td>Name:</td>
              <td><g:textField name="name" size="30"/></td>
            </tr>
            <tr>
              <td>Dauer:</td>
              <td><g:select from="${1..239}" name="duration1" noSelection="['all':'Beliebig']" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
                <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
            </tr>
            <tr>
              <td style="vertical-align: top">Methode:</td>
              <td>
                <g:select name="method" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':'Keine']" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements', params:'\'id=\' + this.value')}"/>

                <div id="elements"></div>

              </td>
            </tr>
          </table>

          <script type="text/javascript">

            function kontrolle2() {

              var selector1 = document.getElementById("selector1");
              if (selector1)
                document.getElementById("hidden").removeChild(selector1);
              var selector2 = document.getElementById("selector2");
              if (selector2)
                document.getElementById("hidden").removeChild(selector2);

              var wme1 = document.createElement("select");
              wme.id = "selector1";
              wme.name = "star1";
              wme.multiple = true;

              var wme2 = document.createElement("select");
              wme.id = "selector2";
              wme.name = "star2";
              wme.multiple = true;

              var checked = new Array();
              for (var zaehler = 0; zaehler < (document.getElementsByName("star1").length); zaehler++) {

                var optn1 = document.createElement("OPTION");
                optn.text = document.getElementsByName("star1")[zaehler].value;
                optn.value = document.getElementsByName("star1")[zaehler].key;
                optn.selected = true;
                wme1.options.add(optn1);

                var optn2 = document.createElement("OPTION");
                optn.text = document.getElementsByName("star2")[zaehler].value;
                optn.value = document.getElementsByName("star2")[zaehler].key;
                optn.selected = true;
                wme2.options.add(optn2);

              }

              document.getElementById("hidden").appendChild(wme1);
              document.getElementById("hidden").appendChild(wme2);
            }

          </script>

          <div id="hidden" style="display: none"></div>

          <g:submitButton onclick="kontrolle2();" name="button" value="Eingrenzen"/>
          <div class="spacer"></div>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addTemplate', id:group.id]" update="templates2" before="showspinner('#templates2')">
          <div id="templateselect" style="margin-top: 10px;">
            <g:render template="searchresults" model="[allTemplates: allTemplates]"/>
          </div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="templates2">
        <g:render template="templates" model="[group: group, templates: templates, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: group]"/>

</body>
