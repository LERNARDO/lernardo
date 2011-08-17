<head>
  <title><g:message code="evaluation.allentry"/></title>
  <meta name="layout" content="private"/>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="evaluation" action="myevaluations" id="${entity.id}"><g:message code="evaluation.myentry"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="evaluation.allentry"/></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    %{--
    <p>Es wurden insgesamt <g:remoteLink controller="evaluation" action="showall" update="remoteEvaluations" id="${entity.id}">${totalEvaluations} Einträge</g:remoteLink> gefunden. Du kannst nach PädagogInnen oder nach Betreuten filtern:</p>
    --}%
    <p><g:message code="evaluation.entrysFound_p1"/> <g:remoteLink controller="evaluation" action="showall" update="remoteEvaluations" id="${entity.id}"><g:message code="evaluation.entrysFound_p2" args="[totalEvaluations]"/></g:remoteLink> <g:message code="evaluation.entrysFound_p3"/></p>

    <g:message code="educator"/>:<br/>
    <g:remoteField size="40" name="remoteField1" update="remoteEvaluations" action="showByEducator" id="${entity.id}" before="showspinner('#remoteEvaluations')"/><br/>

    <g:message code="client"/>:<br/>
    <g:remoteField size="40" name="remoteField2" update="remoteEvaluations" action="showByClient" id="${entity.id}" before="showspinner('#remoteEvaluations')"/>

    <div id="remoteEvaluations">
      <g:render template="evaluations" model="[evaluations: evaluations, totalEvaluations: totalEvaluations, entity: entity, currentEntity: currentEntity]"/>
    </div>

  </div>
</div>
</body>
