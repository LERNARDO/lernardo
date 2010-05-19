<html>
<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Liste aller Profile</title>
  <g:javascript src="jquery/jquery.qtip-1.0.0-rc3.min.js" />
  <script type="text/javascript">
  $(document).ready(function()
  {
    // TODO: figure out why qtip refuses to work although it definitely should
     $('img[src][alt]').qtip({
        content: {
           text: false // Use each elements title attribute
        },
        position: {
           corner: {
              target: 'topMiddle',
              tooltip: 'bottomMiddle'
           }
        },
        style: {
           border: {
              width: 1,
              color: '#89B7DA'
           },
           background: '#EEEEEE'
        }

     });
  });
</script>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Liste aller Profile</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="body-list">
      <p>${entityCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          Typ: <g:select name="entityType" from="${[all:'Alle',Betreiber:'Betreiber',Einrichtung:'Einrichtungen',Paedagoge:'Pädagogen',Betreuter:'Betreute',User:'User',Partner:'Partner',Pate:'Paten',Parent:'Erziehungsberechtigte']}" value="${entityType}" optionKey="key" optionValue="value"/>
        </g:form>

        <script type="text/javascript">
          if ($.browser.msie) {
            $("select[name=entityType]").click(function() {
              $("form[id=form1]").submit();
            });
          }

          $("select[name=entityType]").change(function() {
            $("form[id=form1]").submit();
          });
        </script>
      </div>

      <table id="profile-list">
        <thead>
        <tr>
          <g:sortableColumn property="name" title="Name"/>
          <g:sortableColumn property="type" title="Typ"/>
          <th>Aktiv</th>
          <th>Rechte</th>
          <th>Aktionen</th>
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${entityList}" var="entity">
          <tr class="row-${entity.type.supertype.name}">
            <td>
              <app:isEnabled entity="${entity}">
                <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entity="${entity}">
                <span class="notEnabled">${entity.profile.fullName}</span>
              </app:notEnabled>
            </td>
            <td class="col">${entity.type.name}</td>
            <td class="col"><g:formatBoolean boolean="${entity.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td class="col">${entity.user.authorities.authority}</td>
            <td class="col" style="width: 100px">
              <app:notMe entity="${entity}">
                <app:isEnabled entity="${entity}">
                  <g:link controller="profile" action="disable" id="${entity.id}"><img src="${resource (dir:'images/icons', file:'icon_enabled.png')}" alt="Deaktivieren" align="top"/></g:link>
                </app:isEnabled>
                <app:notEnabled entity="${entity}">
                  <g:link controller="profile" action="enable" id="${entity.id}"><img src="${resource (dir:'images/icons', file:'icon_disabled.png')}" alt="Aktivieren" align="top"/></g:link>
                </app:notEnabled>
                <app:isAdmin>
                  <g:link controller="${entity.type.supertype.name +'Profile'}" action="del" id="${entity.id}" onclick="return confirm('Bist du sicher?');"><img src="${resource (dir:'images/icons', file:'icon_remove.png')}" alt="Löschen" align="top"/></g:link>
                </app:isAdmin>
              </app:notMe>
              <app:isSysAdmin>
                <ub:hasNoRoles entity="${entity}" roles="['ROLE_ADMIN']">
                  <g:link controller="profile" action="giveAdminRole" id="${entity.id}"><img src="${resource (dir:'images/icons', file:'icon_noadmin.png')}" alt="Admin geben" align="top"/></g:link>
                </ub:hasNoRoles>

                <ub:hasAllRoles entity="${entity}" roles="['ROLE_ADMIN']">
                  <g:link controller="profile" action="takeAdminRole" id="${entity.id}"><img src="${resource (dir:'images/icons', file:'icon_anadmin.png')}" alt="Admin nehmen" align="top"/></g:link>
                </ub:hasAllRoles>
              </app:isSysAdmin>
            </td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <g:if test="${entityCount > 10}">
        <div class="paginateButtons">
          <g:paginate action="list"
                  params="[entityType:entityType]"
                  total="${entityCount}"/>
        </div>
      </g:if>

    </div>
  </div>
</div>
</body>
</html>