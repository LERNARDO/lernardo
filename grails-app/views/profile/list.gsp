<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile.list"/></title>
  %{--  <g:javascript src="jquery/jquery.qtip-1.0.0-rc3.min.js" />
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
    </script>--}%
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="profile.list"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="body-list">
      <p>${entityCount} <g:message code="profile.list.c_total"/></p>

      <div id="select-box">
        <g:form name="form1" action="list">
          %{-- }Typ: <g:select name="entityType" from="${[all:'Alle',Betreiber:'Betreiber',Einrichtung:'Einrichtungen',Pädagoge:'Pädagogen',Betreuter:'Betreute',User:'User',Partner:'Partner',Pate:'Pate',Erziehungsberechtigter:'Erziehungsberechtigte',Kind:'Kinder']}" value="${entityType}" optionKey="key" optionValue="value"/>
            --}%

          <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
            <g:select name="entityType" from="${grailsApplication.config.profileType_es}" value="${entityType}" optionKey="key" optionValue="value"/>
          </g:if>
          <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
            <g:select name="entityType" from="${grailsApplication.config.profileType_de}" value="${entityType}" optionKey="key" optionValue="value"/>
          </g:if>


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
          <g:sortableColumn property="name" title="${message(code:'profile.list.name')}"/>
          <g:sortableColumn property="type" title="${message(code:'profile.list.type')}"/>
          <th><g:message code="profile.list.isActiv"/></th>
          <th><g:message code="profile.list.rights"/></th>
          <th><g:message code="profile.list.options"/></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${entityList}" var="entity" status="i">
          <tr id="listentity-${i}" class="row-${entity.type.supertype.name}">
            <g:render template="listentity" model="[entity: entity, currentEntity: currentEntity, i: i]"/>
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