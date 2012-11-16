<h4><g:message code="profile.picture.change"/></h4>

<div class="boxContent">

  <g:uploadForm id="${entity.id}">

    <table>

      <tr class="prop">
        <td class="name"><g:message code="profile.picture.select"/></td>
        <td class="value">
          <input size="40" type="file" name="asset">
        </td>
      </tr>

    </table>

    <div class="info-msg" style="margin-top: 10px;">
      <g:message code="profile.picture.selectInfo"/>
    </div>

    <div class="buttons cleared">
      <div class="button"><g:actionSubmit class="buttonGreen" action="saveProfilePic" value="${message(code: 'save')}" /></div>
      <g:if test="${entity.assets}">
        <g:link class="buttonRed" controller="app" action="deleteProfilePic" id="${entity.id}"><g:message code="delete"/></g:link>
      </g:if>
      <g:link class="buttonGray" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}"><g:message code="cancel"/></g:link>
    </div>

  </g:uploadForm>

</div>