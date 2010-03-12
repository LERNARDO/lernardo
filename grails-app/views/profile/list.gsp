<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Liste aller Profile</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Liste aller Profile</h1>
    </div>
  <div class="boxGray">
    <div id="body-list">
      <p>${entityCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          Typ: <g:select name="entityType" from="${[all:'Alle',Betreiber:'Betreiber',Einrichtung:'Einrichtungen',Pädagoge:'Pädagogen',Betreuter:'Betreute',User:'User',Partner:'Partner',Pate:'Paten',Parent:'Erziehungsberechtigte']}" value="${entityType}" optionKey="key" optionValue="value"/>
          %{--<div class="buttons">
            <g:submitButton name="list" value="OK" />
          </div>--}%
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
          <g:sortableColumn property="name" title="Name" />
          <g:sortableColumn property="type" title="Typ" />
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
            <td class="col"><app:showBoolean bool="${entity.user.enabled}"/></td>
            <td class="col">${entity.user.authorities.authority}</td>
            <td class="col" style="width: 100px">
              <app:isEnabled entity="${entity}">
                <g:link controller="profile" action="disable" id="${entity.id}">Deaktivieren</g:link>
              </app:isEnabled>
              <app:notEnabled entity="${entity}">
                <g:link controller="profile" action="enable" id="${entity.id}">Aktivieren</g:link>
              </app:notEnabled><br/>
              <ub:hasNoRoles entity="${entity}" roles="['ROLE_ADMIN']">
                <g:link controller="profile" action="giveAdminRole" id="${entity.id}">Admin geben</g:link>
              </ub:hasNoRoles>

              <ub:hasAllRoles entity="${entity}" roles="['ROLE_ADMIN']">
                <g:link controller="profile" action="takeAdminRole" id="${entity.id}">Admin nehmen</g:link>
              </ub:hasAllRoles>
            </td> 
          </tr>
        </g:each>
        </tbody>
      </table>

      <g:if test="${entityCount > 10}">
        <div class="paginateButtons">
          <g:paginate action="list"
                      params="[entityType:entityType]"
                      total="${entityCount}" />
        </div>
      </g:if>

    </div>
    </div>
  </body>
</html>