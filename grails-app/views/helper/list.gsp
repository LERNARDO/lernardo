<head>
  <title><g:message code="helpers"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="helpers"/> ${helperFor}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:if test="${helperInstanceList.size() > 0}">
        <g:message code="object.total" args="[helperInstanceList.size(), message(code: 'helpers')]"/>
      </g:if>
      <g:else>
        <g:message code="helper.topic.empty"/>
      </g:else>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'helper')])}"/></div>
          <div class="clear"></div>
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
          <a name="${i}">${helperInstance.title}</a>
          <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
            <g:link class="helperButton" action="edit" id="${helperInstance.id}"><g:message code="edit"/></g:link>
            <g:link class="helperButton" action="del" id="${helperInstance.id}" onclick="return confirm('${message(code:'delete.warn')}');"><g:message code="delete"/></g:link>
          </erp:accessCheck>
          <g:message code="helper"/> für: <g:join in="${helperInstance.types}"/>
          ${helperInstance.content.decodeHTML()}
        </p>
      </div>
    </g:each>
    </g:if>

  </div>
</div>
</body>
