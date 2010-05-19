<div class="headerBlue">
  <div class="second">
    <h1>Kommentare</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <app:isEducator entity="${entity}">
      <div class="comments-actions">
        <a href="#" id="comment-toggler"> Kommentar hinzufügen<img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Kommentar hinzufügen" /></a>
        <jq:jquery>
          <jq:toggle sourceId="comment-toggler" targetId="comment-div"/>
        </jq:jquery>
      </div>
      <div id="comment-div" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'comment', action:'save', id: commented.id]" update="comments" before="hideform('#comment-div')">
          <div class="dialog">

            <div class="value">
              <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
              <fckeditor:editor name="content" id="content" width="570" height="200" toolbar="Post" fileBrowser="default">
              </fckeditor:editor>
            </div>

          </div>
          <div class="buttons">
            <g:submitButton name="submitButton" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </div>
        </g:formRemote>
      </div>
    </app:isEducator>

    <g:render template="/comment/comments" model="[commented: commented]"/>

  </div>
</div>