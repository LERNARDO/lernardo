<head>
  <title><g:message code="profile.picture.title"/></title>
  <meta name="layout" content="database" />
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

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="profile.picture.select"/></td>
            <td valign="top" class="value">
              <input size="40" type="file" name="asset">
            </td>
          </tr>

        </table>

        <div class="info-msg" style="margin-top: 10px;">
          <g:message code="profile.picture.selectInfo"/>
        </div>

        <div class="buttons">
          <div class="button"><g:actionSubmit class="buttonGreen" action="saveProfilePic" value="${message(code: 'save')}" /></div>
          <g:if test="${entity.assets}">
            <g:link class="buttonRed" controller="app" action="deleteProfilePic" id="${entity.id}"><g:message code="delete"/></g:link>
          </g:if>
          <g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}"><g:message code="cancel"/></g:link>
          <div class="clear"></div>
        </div>
        
      </g:uploadForm>

    </div>
  </div>
</body>