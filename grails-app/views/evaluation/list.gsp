<head>
  <title><g:message code="evaluation.evaluation"/></title>
  <meta name="layout" content="database"/>

    <g:javascript>
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "showSingleClient", update: "remoteEvaluations", id: entity.id, before: "showspinner('#remoteEvaluations')")}
        });
    </g:javascript>

</head>
<body>
<div class="boxHeader">
  <h1><g:message code="evaluation.for" args="[entity.profile]"/></h1>
</div>
<div class="boxContent">

    <div class="info-msg">
      <g:message code="evaluation.sizeFor" args="[evaluationInstanceTotal, entity.profile]"/>
    </div>

    <div class="buttons cleared">
      <g:link class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:link>
    </div>

    <div id="remoteEvaluations"></div>

</div>
</body>
