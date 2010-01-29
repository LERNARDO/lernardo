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
          <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
          <fckeditor:editor name="content" id="content" width="600" height="200" toolbar="Post" fileBrowser="default">
            ${postInstance.content}
          </fckeditor:editor>
        </td>
      </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton action="save" name="save" value="Fertig"/></span>
    <span class="nav-button"><a href="#" onclick="jQuery('#createComment').hide(); return false;">Abbrechen</a></span>
  </div>
</g:form>