<head>
  <title><g:message code="evaluation.interesting"/></title>
  <meta name="layout" content="database"/>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="evaluation" action="myevaluations" id="${entity.id}"><g:message code="evaluation.myentry"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="evaluation.interestentry"/></h1>
  </div>
</div>

%{--<erp:accessCheck types="['Betreiber']">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="evaluation" action="allevaluations" id="${entity.id}"><g:message code="evaluation.allentry"/></g:link></h1>
    </div>
  </div>
</erp:accessCheck>--}%

<div class="clear"></div>

<div class="boxGray">

    <div class="info-msg"><g:message code="evaluation.entrySize" args="[evaluationInstanceList.size()]"/></div>
    
    <g:render template="evaluations" model="[evaluationInstanceList: evaluationInstanceList, totalEvaluations: totalEvaluations, paginate: paginate]"/>

</div>
</body>
