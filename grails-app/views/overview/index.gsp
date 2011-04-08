<head>
  <meta name="layout" content="private-cal"/>
  <title><g:message code="profile.overview"/></title>

  <script type="text/javascript">
    $(function() {
      ${remoteFunction(controller:"overview", action: "admin", update: "admin", before: "showspinner('#admin')")}
      ${remoteFunction(controller:"overview", action: "persons", update: "persons", before: "showspinner('#persons')")}
      ${remoteFunction(controller:"overview", action: "other", update: "other", before: "showspinner('#other')")}
      ${remoteFunction(controller:"overview", action: "groups", update: "groups", before: "showspinner('#groups')")}
      ${remoteFunction(controller:"overview", action: "planning", update: "planning", before: "showspinner('#planning')")}
    });
  </script>

</head>
<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile.overview.glossary"/> <a onclick="toggle('#glossar-toggled'); return false" href="index.gsp#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
  </div>
</div>
<div class="boxGray" id="glossar-toggled">
  <div class="second" id="userlist-results">
    <p><g:message code="profile.overview.glossaryLabel"/></p>
    <g:render template="glossary" model="[glossary: glossary]"/>
  </div>
</div>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile.overview.search"/> <a onclick="toggle('#suche-toggled'); return false" href="#"><img alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'icon_add.png')}></a></h1>
  </div>
</div>
<div class="boxGray" id="suche-toggled">
  <div class="second">

    <div id="body-list">
      <g:message code="profile.overview.searchLabel"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe']" before="showspinner('#membersearch-results')" />

      %{-- previous implementation - left here in case the instant search runs into performance issues at some point --}%
      
      %{--<g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
        <fieldset>
          <div class="form-content">
            <div>
              <label for="name">Bitte einen Namen eingeben:</label>
              <input id="name" type="text" name="name"/>
            </div>
            <div class="buttons" style="padding-bottom: 5px">
              <g:submitButton name="button" value="Suchen"/>
              <div class="clear"></div>
            </div>
          </div>
        </fieldset>
      </g:formRemote>--}%

      <div class="membersearch-results" id="membersearch-results">
      </div>

    </div>
  </div>
</div>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile.overview"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      <erp:isAdmin entity="${currentEntity}">
        <div class="overview" id="admin"></div>
      </erp:isAdmin>
      <div class="overview" id="persons"></div>
      <div class="overview" id="other"></div>
      <div class="overview" id="groups"></div>
      <div class="overview" id="planning"></div>

      <div class="clear"></div>

  </div>

</div>
</body>