<div id="liveticker">
  <div class="livetickerdate"><g:remoteLink action="hideticker" update="livetickerbox"><img src="${g.resource(dir:'images/icons', file:'icon_right.png')}" alt="Achtung" align="top"/></g:remoteLink> <g:formatDate date="${new Date()}" format="dd. MM. yyyy, HH:mm:ss"/></div>

  <g:each in="${events}" var="event">
    <div class="livetickerevent">
      <g:formatDate date="${event.date}" format="HH:mm"/><br/>${event.content}
    </div>
  </g:each>
</div>