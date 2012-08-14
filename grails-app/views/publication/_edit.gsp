<%@ page import="at.uenterprise.erp.PublicationType" %>
<div class="boxGray">
  <div class="second">

    <h4><g:message code="object.edit" args="[message(code: 'publication')]"/></h4>

      <g:render template="/templates/errors" model="[bean: publication]"/>

    <g:formRemote name="formRemote" url="[controller: 'publication', action: 'update', id: publication.id]" update="content" before="showspinner('#content');">

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="title"/></td>
            <td valign="top" class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: publication, field: 'name', 'errors')}" id="name" name="name" size="50" value="${fieldValue(bean:publication,field:'name').decodeHTML()}"/>
            </td>
          </tr>

          <g:if test="${publication.entity.user}">
            <tr class="prop">
              <td valign="top" class="name"><g:message code="public"/></td>
              <td valign="top" class="value">
                <g:checkBox name="isPublic" value="${publication.isPublic}"/>
              </td>
            </tr>
          </g:if>

        </table>

        %{--<div>
          <label for="category">Kategorie:</label><br />
          <g:select id="category" name="type.id" value="${publication?.type?.id}"
            from="${types}"
            optionKey="id"
            optionValue="name"
            noSelection="${['null':'Bitte auswählen...']}">
          </g:select>
        </div>--}%

        <div class="buttons">
          <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="${message(code: 'change')}" /></div>
          <g:remoteLink class="buttonGray" update="content" controller="publication" action="list" id="${publication.entity.id}"><g:message code="cancel"/></g:remoteLink>
          <div class="clear"></div>
        </div>

      </g:formRemote>
    </div>
  </div>