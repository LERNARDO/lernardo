<head>
  <title><g:message code="profile.picture.title"/></title>
  <meta name="layout" content="private" />
</head>
<body>
  <div class="boxHeader">
    <div class="second">
      <h1><g:message code="profile.picture.change"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <g:if test="${asset}">
        <g:message code="profile.picture.select.ok"/>
      </g:if>
      <g:else>
        <g:message code="profile.picture.select.err"/>
      </g:else>
    </div>
  </div>
</body>