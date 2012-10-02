<head>
  <title><g:message code="evaluation.interesting"/></title>
  <meta name="layout" content="database"/>
</head>
<body>

<div class="tabInactive">
    <h1><g:link controller="evaluation" action="myevaluations" id="${entity.id}"><g:message code="evaluation.myentry"/></g:link></h1>
</div>

<div class="tabActive">
    <h1><g:message code="evaluation.interestentry"/></h1>
</div>

%{--<erp:accessCheck types="['Betreiber']">
  <div class="tabInactive">
      <h1><g:link controller="evaluation" action="allevaluations" id="${entity.id}"><g:message code="evaluation.allentry"/></g:link></h1>
  </div>
</erp:accessCheck>--}%

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg"><g:message code="evaluation.entrySize" args="[evaluationInstanceList.size()]"/></div>
    
    <g:render template="evaluations" model="[evaluationInstanceList: evaluationInstanceList, totalEvaluations: totalEvaluations, paginate: paginate]"/>

</div>
</body>
