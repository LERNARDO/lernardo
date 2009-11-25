<g:form action="save" method="post" id="${template_id}">
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="content">
            <g:message code="post.content.label" default="Inhalt"/>
          </label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'content', 'errors')}">
          <textarea rows="20" cols="80" name="content">${fieldValue(bean:postInstance, field:'content')}</textarea>
        </td>
      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><input class="save" type="submit" value="Fertig"/></span>
    <span class="button"><a href="#" onclick="jQuery('#createComment').hide(); return false;">Abbrechen</a></span>
  </div>
</g:form>