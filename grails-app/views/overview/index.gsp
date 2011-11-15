<head>
  <meta name="layout" content="private-ov"/>
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
    <h1><g:message code="profile.overview"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
        <div class="overview" id="admin"></div>
      </erp:accessCheck>
      <div class="overview" id="persons"></div>
      <div class="overview" id="other"></div>
      <div class="overview" id="groups"></div>
      <div class="overview" id="planning"></div>

      <div class="clear"></div>

  </div>

</div>
</body>