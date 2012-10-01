<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="profile.overview"/></title>

  <script type="text/javascript">
    $(function() {
      ${remoteFunction(controller: "overview", action: "admin", update: "admin", before: "showspinner('#admin')")}
      ${remoteFunction(controller: "overview", action: "persons", update: "persons", before: "showspinner('#persons')")}
      ${remoteFunction(controller: "overview", action: "other", update: "others", before: "showspinner('#others')")}
      ${remoteFunction(controller: "overview", action: "groups", update: "groups", before: "showspinner('#groups')")}
      ${remoteFunction(controller: "overview", action: "planning", update: "planning", before: "showspinner('#planning')")}
    });
  </script>

</head>
<body>

<div class="boxHeader">
  <h1><g:message code="profile.overview.glossary"/> <img onclick="toggle('#glossar-toggled');" alt="ein-/ausblenden" src=${resource(dir: '/images/icons/', file:'bullet_arrow_toggle.png')}></h1>
</div>
<div class="boxGray" id="glossar-toggled">
  <div class="second" id="userlist-results">
    <p><g:message code="profile.overview.glossaryLabel"/></p>
    <g:render template="glossary" model="[glossary: glossary]"/>
  </div>
</div>

<div class="boxHeader">
  <h1><g:message code="profile.overview"/></h1>
</div>
<div class="boxGray">

      <erp:accessCheck roles="['ROLE_ADMIN']">
        <div class="overview" id="admin"></div>
      </erp:accessCheck>
      <div class="overview" id="persons"></div>
      <div class="overview" id="others"></div>
      <div class="overview" id="groups"></div>
      <div class="overview" id="planning"></div>

      <div class="clear"></div>

</div>
</body>