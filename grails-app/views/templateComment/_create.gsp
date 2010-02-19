<g:form action="save" method="post" id="${template_id}">
  <div class="dialog">

    <div class="value ${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
      <fckeditor:editor name="content" id="content" width="570" height="200" toolbar="Post" fileBrowser="default">
        ${postInstance.content}
      </fckeditor:editor>
    </div>

  </div>
  <div class="buttons">
    <g:submitButton name="submitButton" value="Fertig"/>
    <a class="buttonGray" href="#" onclick="jQuery('#createComment').hide(); return false;">Abbrechen</a>
    <div class="spacer"></div>
  </div>
</g:form>