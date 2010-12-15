 <g:formRemote name="formRemote" url="[controller:'comment', action:'update', id: commented.id, params:[comment:comment.id, i: i]]" update="comment${i}" before="for ( var i = 0; i < parent.frames.length; ++i ) if ( parent.frames[i].FCK ) parent.frames[i].FCK.UpdateLinkedField();">
  <div class="dialog">

    <div class="value">
      <g:textArea rows="5" cols="125" name="content" value="${comment.content}"/>
    </div>

  </div>
  <div class="buttons">
    <g:submitButton name="submitButton" value="${message(code:'change')}"/>
    <div class="spacer"></div>
  </div>
</g:formRemote>