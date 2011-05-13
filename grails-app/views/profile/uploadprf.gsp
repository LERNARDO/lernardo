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
      <g:uploadForm id="${entity.id}">
        <p><g:message code="profile.picture.select"/>:<br/>
        <input size="40" type="file" name="asset"></p>

        <p><g:message code="profile.picture.selectInfo"/></p>

        <div class="buttons">
          <div class="button"><g:actionSubmit class="buttonGreen" action="putprf" value="${message(code: 'save')}" /></div>
          %{--<g:submitButton name="submit" value="${message(code:'save')}"/>--}%
          <g:if test="${entity.assets}">
            <div class="button"><g:actionSubmit class="buttonRed" controller="app" action="deleteProfilePic" value="${message(code: 'delete')}" /></div>
            %{--<g:link class="buttonRed" controller="app" action="deleteProfilePic" id="${entity.id}"><g:message code="delete"/></g:link>--}%
          </g:if>
          %{--<g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}"><g:message code="cancel"/></g:link>--}%
          <div class="spacer"></div>
        </div>
        
      </g:uploadForm>

    </div>
  </div>
</body>