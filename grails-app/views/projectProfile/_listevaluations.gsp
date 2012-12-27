<h4>Tagebucheinträge verknüpft mit ${entity.profile}</h4>

<div class="boxContent">

    <div class="info-msg">
      Es gibt insgesamt ${evaluations.size()} Tagebucheinträge verknüpft mit ${entity.profile}
    </div>

%{--    <div class="buttons cleared">
      <g:link class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:link>
    </div>--}%

    <ul>
      <g:each in="${evaluations}" status="i" var="evaluation">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="date"/>:</td>
              <td><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="description"/>:</td>
              <td>${evaluation.description.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="action"/>:</td>
              <td>${evaluation.method.decodeHTML()}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="from"/>:</td>
              <td>${evaluation.writer.profile}</td>
            </tr>
            <tr>
              <td class="bold vtop"><g:message code="linkedTo"/>:</td>
              <td><span id="linkedTo${i}"><g:if test="${evaluation.linkedTo}">${evaluation.linkedTo.profile} <erp:accessCheck types="['Betreiber']" me="${evaluation.writer}"><g:remoteLink action="removeLinkedTo" update="linkedTo${i}" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if><g:else><span class="italic">Nicht verlinkt</span></g:else></span></td>
            </tr>
          </table>
          %{--<erp:accessCheck types="['Betreiber']" me="${evaluation.writer}">
            <g:link class="helperButton" action="edit" id="${evaluation.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
          </erp:accessCheck>--}%
        </div>
      </g:each>
    </ul>

</div>
