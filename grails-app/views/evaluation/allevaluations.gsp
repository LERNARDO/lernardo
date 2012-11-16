<head>
  <title><g:message code="evaluation.allevalentries"/></title>
  <meta name="layout" content="administration"/>

    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "showAll", update: "remoteEvaluations", id: entity.id)}
        });
    </script>

</head>
<body>

<div class="boxHeader">
  <h1><g:message code="evaluation.allevalentries"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg"><g:message code="evaluation.entrysFound_p1"/> <g:remoteLink update="remoteEvaluations" controller="evaluation" action="showAll" id="${entity.id}" before="showspinner('#remoteEvaluations')"><g:message code="evaluation.entrysFound_p2" args="[totalEvaluations]"/></g:remoteLink> <g:message code="evaluation.entrysFound_p3"/></div>

    <g:message code="educator"/>:<br/>
    <g:remoteField size="40" name="remoteField1" update="remoteEvaluations" action="showByEducator" id="${entity.id}" before="showspinner('#remoteEvaluations')"/><br/>

    <g:message code="client"/>:<br/>
    <g:remoteField size="40" name="remoteField2" update="remoteEvaluations" action="showByClient" id="${entity.id}" before="showspinner('#remoteEvaluations')"/>

    <div id="remoteEvaluations" style="margin-top: 10px;"></div>

</div>
</body>
