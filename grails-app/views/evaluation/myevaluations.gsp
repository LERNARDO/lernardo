<head>
  <title><g:message code="evaluation.personel"/></title>
  <meta name="layout" content="private"/>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="evaluation.myentry"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="evaluation" action="interestingevaluations" id="${entity.id}"><g:message code="evaluation.interestentry"/></g:link></h1>
  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="evaluation" action="listall" id="${entity.id}"><g:message code="evaluation.allentry"/></g:link></h1>
    </div>
  </div>
</erp:accessCheck>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    %{--<p>Du hast insgesamt ${evaluationInstanceTotal} Tagebucheinträge erstellt.</p>--}%
    <p><g:message code="evaluation.entryinserted" args="[evaluationInstanceTotal]"/></p>

    <ul>
      <g:each in="${evaluationInstanceList}" status="i" var="evaluation">
        <div class="leistung-item">
          <table cellpadding="2">
            <tr>
              <td class="bold vtop"><g:message code="client"/>:</td>
              <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
            </tr>
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
              <td class="bold vtop"><g:message code="linkedTo"/>:</td>
              <td><span id="linkedTo${i}"><g:if test="${evaluation.linkedTo}"><g:link controller="${evaluation.linkedTo.type.supertype.name +'Profile'}" action="show" id="${evaluation.linkedTo.id}">${evaluation.linkedTo.profile.fullName}</g:link> <erp:isMeOrAdminOrOperator entity="${evaluation.writer}" current="${currentEntity}"><g:remoteLink action="removeLinkedTo" update="linkedTo${i}" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:isMeOrAdminOrOperator></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></span></td>
            </tr>
          </table>
          <erp:isMeOrAdminOrOperator entity="${evaluation.writer}" current="${currentEntity}">
            <g:link class="helperButton" action="edit" id="${evaluation.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
          </erp:isMeOrAdminOrOperator>
        </div>
      </g:each>
    </ul>

    <div class="paginateButtons">
      <g:paginate action="myevaluations" total="${evaluationInstanceTotal}" id="${entity.id}"/>
    </div>

  </div>
</div>
</body>
