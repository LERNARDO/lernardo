<div class="headerGreen">
  <div class="second">
    <h1>Kommentare</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    %{--<erp:isEducator entity="${currentEntity}">--}%
      <div class="add-comment">
        <a onclick="toggle('#comment-div'); return false" href="#">Kommentar hinzufügen <img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Kommentar hinzufügen" /></a>
      </div>
      <div id="comment-div" style="display:none; margin-bottom: 10px">
        <g:formRemote name="formRemote" url="[controller:'comment', action:'save', id: commented.id]" update="comments" before="hideform('#comment-div');">
          <div class="dialog">

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
    %{--</erp:isEducator>--}%

    <g:render template="/comment/comments" model="[currentEntity: currentEntity, commented: commented]"/>

  </div>
</div>