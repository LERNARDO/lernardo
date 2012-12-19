<head>
  <title><g:message code="evaluation"/></title>
  <meta name="layout" content="database"/>
</head>
<body>

  <div class="boxHeader">
    <h1><g:message code="evaluation"/></h1>
  </div>

  <table>

    <tr class="prop">
      <td class="one"><g:message code="from"/>:</td>
      <td class="two">${evaluation.writer.profile}</td>
    </tr>

    <tr class="prop">
      <td class="one"><g:message code="client"/>:</td>
      <td class="two"><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile}</g:link></td>
    </tr>

    <tr class="prop">
      <td class="one"><g:message code="date"/>:</td>
      <td class="two"><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
    </tr>

    <tr class="prop">
      <td class="one"><g:message code="title"/>:</td>
      <td class="two">${evaluation.title.decodeHTML()}</td>
    </tr>

    <tr class="prop">
      <td class="one"><g:message code="description"/>:</td>
      <td class="two">${evaluation.description.decodeHTML()}</td>
    </tr>

    <tr class="prop">
      <td class="one"><g:message code="action"/>:</td>
      <td class="two">${evaluation.method.decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    
    <tr class="prop">
      <td class="one"><g:message code="linkedTo"/>:</td>
      <td class="two"><span id="linkedTo"><g:if test="${evaluation.linkedTo}"><erp:createLinkFromEvaluation linked="${evaluation.linkedTo}"/> <erp:accessCheck types="['Betreiber']" me="${evaluation.writer}"><g:remoteLink action="removeLinkedTo" update="linkedTo" id="${evaluation.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></span></td>
    </tr>

  </table>


    <div class="buttons cleared">
        <erp:accessCheck types="['Betreiber']" me="${evaluation.writer}">
            <g:form id="${evaluation?.id}" params="[entity: entity.id]">
                <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
            </g:form>
        </erp:accessCheck>
        <div class="button"><a class="buttonGreen" href="#" onclick="jQuery('#modal').modal(); return false">PDF</a></div>
    </div>

<div id="modal" style="display: none;">
    <g:form action="createpdf" id="${evaluation.id}">
        <p><g:message code="selectPageFormat"/></p>
        <g:render template="/templates/printRadioGroup"/>
        <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
    </g:form>
</div>

</body>