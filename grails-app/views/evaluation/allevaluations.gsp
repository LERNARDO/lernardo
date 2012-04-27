<head>
  <title><g:message code="evaluation.allevalentries"/></title>
  <meta name="layout" content="administration"/>
</head>
<body>

<div class="boxHeader">
  <h1><g:message code="evaluation.allevalentries"/></h1>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg"><g:message code="evaluation.entrysFound_p1"/> <g:link controller="evaluation" action="allevaluations" id="${entity.id}" params="[show: true]"><g:message code="evaluation.entrysFound_p2" args="[totalEvaluations]"/></g:link> <g:message code="evaluation.entrysFound_p3"/></div>

    <g:message code="educator"/>:<br/>
    <g:remoteField size="40" name="remoteField1" update="remoteEvaluations" action="showByEducator" id="${entity.id}" before="showspinner('#remoteEvaluations')"/><br/>

    <g:message code="client"/>:<br/>
    <g:remoteField size="40" name="remoteField2" update="remoteEvaluations" action="showByClient" id="${entity.id}" before="showspinner('#remoteEvaluations')"/>

    <div id="remoteEvaluations">
      <g:if test="${show}">
        <g:render template="evaluations" model="[evaluationInstanceList: evaluations, totalEvaluations: totalEvaluations, entity: entity, paginate: paginate]"/>
      </g:if>
    </div>

  </div>
</div>
</body>
