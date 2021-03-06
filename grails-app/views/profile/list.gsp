<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="profile.list"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="profile.list"/></h1>
</div>
<div class="boxContent">

      <div class="info-msg">
        <g:message code="object.total" args="[entityCount, message(code: 'profiles')]"/>
      </div>

      <div id="select-box" style="margin-top: 10px">
        <g:form name="form1" action="list">
          <g:select name="entityType" from="${grailsApplication.config.profiletypes}" value="${entityType}" valueMessagePrefix="profiletype"/>
        </g:form>

        <script type="text/javascript">
          $("select[name=entityType]").change(function() {
            $("form[id=form1]").submit();
          });
        </script>

      </div>

      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="name" title="${message(code:'name')}" params="[entityType: entityType]"/>
          <g:sortableColumn property="type" title="${message(code:'type')}" params="[entityType: entityType]"/>
          <th><g:message code="profile.list.isActiv"/></th>
          <th><g:message code="lastOnline"/></th>
          <th><g:message code="profile.list.rights"/></th>
          <th><g:message code="profile.list.options"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${entityList}" var="entity" status="i">
          <tr id="listentity-${i}">
            <g:render template="listentity" model="[entity: entity, i: i]"/>
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
</body>