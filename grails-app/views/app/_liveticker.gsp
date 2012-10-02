<div class="liveHeader">
    <h1>Liveticker <span class="livetickerdate">%{--<g:remoteLink action="hideticker" update="livetickerbox"><img src="${g.resource(dir:'images/icons', file:'icon_up.png')}" alt="Achtung" align="top"/></g:remoteLink>--}%<g:formatDate date="${new Date()}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:if test="${events.size() == 1}"><b><g:message code="ticker.event"/></b></g:if><g:elseif test="${events.size() > 1}"><b><g:message code="ticker.events" args="[events.size()]"/></b></g:elseif></span></h1>
</div>
<div class="boxContent">

  <g:if test="${events}">
  <g:each in="${events}" var="event">
    %{--Difference in ms: ${new Date().getTime() - event.date.getTime()}<br/>
    Factor: ${1/300}<br/>
    Alpha: ${1 - (1/300) * (new Date().getTime() - event.date.getTime()) / 1000}<br/>--}%
    %{--<g:if test="${new Date().getTime() - event.dateCreated.getTime() < 300000}">
      <g:set var="transparency" value="${1 - (1/300) * (new Date().getTime() - event.dateCreated.getTime()) / 1000}"/>
    </g:if>
    <g:else>
      <g:set var="transparency" value="0"/>
    </g:else>--}%
    <div class="livetickerevent" %{--style="background: rgba(0,0,200,${transparency}); color: rgba(${(transparency * 255).toInteger()},${(transparency * 255).toInteger()},${(transparency * 255).toInteger()},1);"--}%>
      <g:formatDate date="${event.dateCreated}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>${event.content}
    </div>
  </g:each>
  </g:if>
  <g:else>
    <span class="italic">Keine Live Ereignisse</span>
  </g:else>
</div>