<div class="boxContent">

    <h4><g:message code="comments"/></h4>

    <div class="add-comment">
      <a onclick="toggle('#comment-div'); return false" href="#"><g:message code="comment.add"/> <img src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}" /></a>
    </div>
    <div id="comment-div" style="display:none; margin-bottom: 10px">
      <g:formRemote name="formRemote" url="[controller: 'comment', action: 'save', id: commented.id]" update="comments" before="toggle('#comment-div'); showspinner('#comments');">
        <div>

          <div class="value">
            %{--<g:textArea id="commenttext" rows="5" cols="70" name="content" value=""/>--}%
            <ckeditor:editor name="comment_content" height="200px" toolbar="Basic" removeInstance="true">

            </ckeditor:editor>
          </div>

        </div>
        <div class="buttons cleared">
          <div class="button"><g:submitButton class="buttonGreen" name="submitButton" onclick="javascript: for ( instance in CKEDITOR.instances )
        CKEDITOR.instances[instance].updateElement(); CKEDITOR.instances[instance].setData('');" value="${message(code:'add')}"/></div>
        </div>
      </g:formRemote>
    </div>

    <g:render template="/comment/comments" model="[commented: commented]"/>

</div>