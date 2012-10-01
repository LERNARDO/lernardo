<head>
  <title><g:message code="helpers"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="helpers"/> ${helperFor}</h1>
</div>
<div class="boxGray">

    <div class="info-msg">
      <g:if test="${helperInstanceList.size() > 0}">
        <g:message code="object.total" args="[helperInstanceList.size(), message(code: 'helpers')]"/>
      </g:if>
      <g:else>
        <g:message code="helper.topic.empty"/>
      </g:else>
    </div>

    <erp:accessCheck roles="['ROLE_ADMIN']">
      <div class="buttons cleared">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'helper')])}"/></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:if test="${helperInstanceList.size() > 0}">
    <ul>
      <g:each in="${helperInstanceList}" status="i" var="helperInstance">
        <li><a href="#${i}">${helperInstance.title}</a></li>
      </g:each>
    </ul>

    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <div class="helperbox">
        <p>
          <a name="${i}" style="color: #444; font-weight: bold;">${helperInstance.title}</a>
          <erp:accessCheck roles="['ROLE_ADMIN']">
            <g:link action="edit" id="${helperInstance.id}"><img src="${g.resource(dir:'images/icons', file:'icon_edit2.png')}" alt="Edit" align="top"/></g:link>
            <g:link action="del" id="${helperInstance.id}" onclick="return confirm('${message(code:'delete.warn')}');"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Remove" align="top"/></g:link>
          </erp:accessCheck>
          <span class="gray">(<g:message code="helper"/> für: 
          <g:each in="${helperInstance.types}" var="type">
            <g:message code="profiletype.${type}"/>,
          </g:each>)</span>
          ${helperInstance.content.decodeHTML()}
        </p>
      </div>
    </g:each>
    </g:if>

</div>
</body>
