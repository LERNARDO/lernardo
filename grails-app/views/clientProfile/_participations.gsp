<g:if test="${current == 'true'}">
    <h4><g:message code="participations.current"/> - <g:remoteLink update="content" controller="clientProfile" action="participations" id="${clientId}" params="[current: 'false']" before="showspinner('#content');"><g:message code="participations.old"/></g:remoteLink></h4>
</g:if>
<g:else>
    <h4><g:remoteLink update="content" controller="clientProfile" action="participations" id="${clientId}" params="[current: 'true']" before="showspinner('#content');"><g:message code="participations.current"/></g:remoteLink> - <g:message code="participations.old"/></h4>
</g:else>


<div class="info-msg">
    <g:message code="object.found" args="[results.size(), message(code: 'participations')]"/>
</div>

<g:each in="${results}" var="result" status="i">
    <g:render template="/templates/member" model="[entity: result, i: i]"/>
</g:each>
<div class="clear"></div>