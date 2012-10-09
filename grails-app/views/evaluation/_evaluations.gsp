<g:if test="${evaluationInstanceList}">
  <table class="default-table">
    <thead>
    <tr>
      <th><g:message code="date"/></th>
      <th><g:message code="title"/></th>
      <th><g:message code="linkedTo"/></th>
      <th><g:message code="client"/></th>
      <th><g:message code="from"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${evaluationInstanceList}" status="i" var="evaluation">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" id="line-${i}">
        <td>
          <erp:accessCheck types="['Betreiber']" me="${evaluation.writer}">
            <g:remoteLink action="delete" update="line-${i}" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink>
          </erp:accessCheck>
          <g:link action="show" id="${evaluation.id}" params="[entity: entity.id]"><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></g:link>
        </td>
        <td>${evaluation.title}</td>
        <td><span id="linkedTo${i}"><g:if test="${evaluation.linkedTo}"><erp:createLinkFromEvaluation linked="${evaluation.linkedTo}"/> <erp:accessCheck types="['Betreiber']" me="${evaluation.writer}"><g:remoteLink action="removeLinkedTo" update="linkedTo${i}" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></span></td>
        <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile}</g:link></td>
        <td>${evaluation.writer.profile}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</g:if>

<g:if test="${paginate == 'own'}">
  <div class="paginateButtons">
    <util:remotePaginate action="showMine" total="${totalEvaluations}" update="remoteEvaluations" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}" params="[value: value]"/>
  </div>
</g:if>

<g:if test="${paginate == 'interesting'}">
  <div class="paginateButtons">
    <g:paginate action="interestingevaluations" total="${totalEvaluations}" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}"/>
  </div>
</g:if>

<g:if test="${paginate == 'allClient'}">
  <div class="paginateButtons">
    <util:remotePaginate action="showByClient" total="${totalEvaluations}" update="remoteEvaluations" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}" params="[value: value]"/>
  </div>
</g:if>

<g:if test="${paginate == 'allEducator'}">
  <div class="paginateButtons">
    <util:remotePaginate action="showByEducator" total="${totalEvaluations}" update="remoteEvaluations" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}" params="[value: value]"/>
  </div>
</g:if>
