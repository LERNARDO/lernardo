<%@ page import="at.uenterprise.erp.PublicationType" %>
<div class="boxGray">

      <h4><g:message code="object.create" args="[message(code: 'publication')]"/></h4>

      <g:hasErrors bean="${publication}">
        <div class="errors">
          <g:renderErrors bean="${publication}" as="list"/>
        </div>
      </g:hasErrors>

      <g:uploadForm id="${entity.id}">

        <table>

          <tr class="prop">
            <td class="name"><g:message code="title"/></td>
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: publication, field: 'name', 'errors')}" id="name" name="name" size="50" value="${fieldValue(bean:publication,field:'name').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="publication.profile.file"/></td>
            <td class="value">
              <input size="50" id="file" type="file" name="file"/>
            </td>
          </tr>

          <g:if test="${entity.user}">
            <tr class="prop">
              <td class="name"><g:message code="public"/></td>
              <td class="value">
                <g:checkBox name="isPublic" value="${false}"/>
              </td>
            </tr>
          </g:if>

        </table>

        %{-- 06.08.2010: disabled for now --}%
        %{--<div>
          <label for="category"><g:message code="publication.profile.category"/>:</label><br />
          <g:select id="category" name="type.id" value="${publication?.type?.id}"
            from="${PublicationType.list()}"
            optionKey="id"
            optionValue="name"
            noSelection="${['null': message(code:'publication.profile.categoryEmpty')]}">
          </g:select>
        </div>--}%

        %{-- TODO: uncomment when implemented
        <div>
          <br/>
          <label for="category"><g:message code="publication.profile.share"/>:</label><br />
          <g:select name="accesslevel"
            from="${[0:'Alle',1:'Netzwerk & Freunde',2:'nur Freunde',3:'Privat']}"
            optionKey="key"
            optionValue="value"
            noSelection="${['null': message(code:'publication.profile.categoryEmpty')]}">
          </g:select>
        </div>--}%

        %{--<div class="file-field">
          <label for="file"><g:message code="publication.profile.file"/>:</label><br />
          <input size="50" id="file" type="file" name="file"/>
        </div>--}%

        <div class="buttons cleared">
          <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
          <div class="button"><g:remoteLink class="buttonGray" update="content" controller="publication" action="list" id="${entity.id}"><g:message code="cancel"/></g:remoteLink></div>
        </div>

      </g:uploadForm>
    </div>
