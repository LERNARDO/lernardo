<h4><g:remoteLink update="content" controller="evaluation" action="myevaluations" id="${entity.id}" before="showspinner('#content');"><g:message code="evaluation.myentry"/></g:remoteLink> - <g:message code="evaluation.interestentry"/></h4>

<div class="clear"></div>

<div class="boxContent">

    <div class="info-msg"><g:message code="evaluation.entrySize" args="[totalEvaluations]"/></div>
    
    <g:render template="evaluations" model="[evaluationInstanceList: evaluationInstanceList, totalEvaluations: totalEvaluations, paginate: paginate]"/>

</div>