<div class="boxHeader">
  <div class="second">
    <h1><g:message code="comments"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="add-comment">
      <a onclick="toggle('#comment-div'); return false" href="#"><g:message code="comment.add"/> <img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}" /></a>
    </div>
    <div id="comment-div" style="display:none; margin-bottom: 10px">
      <g:formRemote name="formRemote" url="[controller:'comment', action:'save', id: commented.id]" update="comments" before="hideform('#comment-div');">
        <div>

          <div class="value">
            <g:textArea rows="5" cols="125" name="content" value=""/>
          </div>

        </div>
        <div class="buttons">
          <g:submitButton name="submitButton" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </div>
      </g:formRemote>
    </div>

    <g:render template="/comment/comments" model="[currentEntity: currentEntity, commented: commented]"/>

  </div>
</div>