<h4><g:message code="evaluation.for" args="[entity.profile]"/></h4>

<div class="boxContent">

    <div class="info-msg">
      <g:message code="evaluation.sizeFor" args="[evaluationInstanceTotal, entity.profile]"/>
    </div>

    <div class="buttons">
      <g:remoteLink update="content" class="buttonGreen" action="create" id="${entity.id}"><g:message code="evaluation.create"/></g:remoteLink>
    </div>

    <div id="remoteEvaluations" style="padding-top: 40px;"></div>

</div>

<script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "showSingleClient", update: "remoteEvaluations", id: entity.id, before: "showspinner('#remoteEvaluations')")}
    });
</script>