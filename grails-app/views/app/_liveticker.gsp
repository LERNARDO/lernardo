<div id="liveticker">
  <div class="livetickerdate"><g:remoteLink action="hideticker" update="livetickerbox"><img src="${g.resource(dir:'images/icons', file:'icon_right.png')}" alt="Achtung" align="top"/></g:remoteLink> <g:formatDate date="${new Date()}" format="dd. MM. yyyy, HH:mm"/></div>

  <g:each in="${events}" var="event">
    %{--Difference in ms: ${new Date().getTime() - event.date.getTime()}<br/>
    Factor: ${1/300}<br/>
    Alpha: ${1 - (1/300) * (new Date().getTime() - event.date.getTime()) / 1000}<br/>--}%
    <g:if test="${new Date().getTime() - event.dateCreated.getTime() < 300000}">
      <g:set var="transparency" value="${1 - (1/300) * (new Date().getTime() - event.dateCreated.getTime()) / 1000}"/>
    </g:if>
    <g:else>
      <g:set var="transparency" value="0"/>
    </g:else>
    <div class="livetickerevent" style="background: rgba(0,255,0,${transparency})">
      <g:formatDate date="${event.dateCreated}" format="HH:mm"/><br/>${event.content}
    </div>
  </g:each>
</div>