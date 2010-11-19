<head>
  <title><g:message code="helper.topic"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="helper.topic"/> ${helperFor}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${helperInstanceList.size() > 0}">
      <p> ${helperInstanceList.size()} <g:message code="helper.topic.c_total"/> </p>
    </g:if>
    <g:else>
      <g:message code="helper.topic.empty"/>.
    </g:else>

    <app:isAdmin>
      <div class="buttons">
        <g:link class="buttonGreen" action="create" params="[entity:entity.id]"><g:message code="helper.topic.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isAdmin>

    <g:if test="${helperInstanceList.size() > 0}">
    <ul>
      <g:each in="${helperInstanceList}" status="i" var="helperInstance">
        <li><a href="#${i}">${helperInstance.title}</a></li>
      </g:each>
    </ul>

    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <div class="helperbox">
        <p>
          <a name="${i}">${helperInstance.title}</a><app:isAdmin><g:link class="helperButton" action="edit" id="${helperInstance.id}" params="[entity:entity.id]"><g:message code="edit"/></g:link>
          Hilfethema für: <g:join in="${helperInstance.types}"/></p></app:isAdmin>
          ${helperInstance.content.decodeHTML()}</p>
      </div>
    </g:each>
    </g:if>

  </div>
</div>
</body>
