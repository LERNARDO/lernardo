<div class="boxGray">
  <div class="second">

    <h4><g:message code="comments"/></h4>

    <div class="add-comment">
      <a onclick="clearElements(['#commenttext']); toggle('#comment-div'); return false" href="#"><g:message code="comment.add"/> <img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}" /></a>
    </div>
    <div id="comment-div" style="display:none; margin-bottom: 10px">
      <g:formRemote name="formRemote" url="[controller:'comment', action:'save', id: commented.id]" update="comments" before="toggle('#comment-div');">
        <div>

          <div class="value">
            <g:textArea id="commenttext" rows="5" cols="70" name="content" value=""/>
          </div>

        </div>
        <div class="buttons">
          <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'add')}"/></div>
          <div class="spacer"></div>
        </div>
      </g:formRemote>
    </div>

    <g:render template="/comment/comments" model="[currentEntity: currentEntity, commented: commented]"/>

  </div>
</div>