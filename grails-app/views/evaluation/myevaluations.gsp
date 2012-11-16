<head>
  <title><g:message code="evaluation.personel"/></title>
  <meta name="layout" content="database"/>

  <script type="text/javascript">
      $(function() {
        ${remoteFunction(controller: "evaluation", action: "showMine", update: "remoteEvaluations", id: entity.id, params: [value: ""])}
      });
    </script>

</head>
<body>

<div class="tabActive">
    <h1><g:message code="evaluation.myentry"/></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="evaluation" action="interestingevaluations" id="${entity.id}"><g:message code="evaluation.interestentry"/></g:link></h1>
</div>

%{--<erp:accessCheck types="['Betreiber']">
  <div class="tabInactive">
      <h1><g:link controller="evaluation" action="allevaluations" id="${entity.id}"><g:message code="evaluation.allentry"/></g:link></h1>
  </div>
</erp:accessCheck>--}%

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg"><g:message code="evaluation.entryinserted" args="[evaluationInstanceTotal]"/></div>

    <g:message code="client"/>:<br/>
    <g:remoteField size="40" name="remoteField" update="remoteEvaluations" action="showMine" id="${entity.id}" before="showspinner('#remoteEvaluations')"/>

    <div id="remoteEvaluations"></div>

</div>
</body>
