<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="labels"/></title>
</head>
<body>

<div class="tabInactive">
    <h1><g:link controller="setup" action="show">Setup</g:link></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="method" action="index"><g:message code="vMethods"/></g:link></h1>
</div>

<div class="tabActive">
    <h1><g:message code="labels"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="object.total" args="[labelInstanceTotal, message(code: 'labels')]"/>
    </div>

     <erp:accessCheck types="['Betreiber']">
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'label')])}"/></div>
          <div class="button"><g:actionSubmit class="buttonGreen" action="sortAlphabetical" value="${message(code: 'sortByAlpha')}" onclick="return confirm('${message(code: 'sure')}');"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'name')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${labelInstanceList}" status="i" var="label">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" onmouseover="$('#arrows${i}').toggle()" onmouseout="$('#arrows${i}').toggle()">
          <td><span id="arrows${i}" style="display: none;"><g:link action="moveUp" id="${label.id}"><img src="${g.resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="${message(code:'up')}" align="top"/></g:link> <g:link action="moveDown" id="${label.id}"><img src="${g.resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="${message(code:'down')}" align="top"/></g:link></span> <g:link action="show" id="${label.id}">${fieldValue(bean: label, field: 'name').decodeHTML()}</g:link></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    %{--<div class="paginateButtons">
      <g:paginate total="${labelInstanceTotal}"/>
    </div>--}%

</div>
</body>

