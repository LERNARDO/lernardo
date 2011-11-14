<g:if test="${evaluationInstanceList}">
  <table class="default-table">
    <thead>
    <tr>
      <th><g:message code="date"/></th>
      <th><g:message code="linkedTo"/></th>
      <th><g:message code="client"/></th>
      <th><g:message code="from"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${evaluationInstanceList}" status="i" var="evaluation">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:link action="show" id="${evaluation.id}" params="[entity: entity.id]"><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:link></td>
        <td><span id="linkedTo${i}"><g:if test="${evaluation.linkedTo}"><erp:createLinkFromEvaluation evaluation="${evaluation}"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${evaluation.writer}"><g:remoteLink action="removeLinkedTo" update="linkedTo${i}" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></span></td>
        <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
        <td>${evaluation.writer.profile.fullName}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</g:if>
