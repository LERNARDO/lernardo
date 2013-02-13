<h4><g:message code="evaluation.edit"/></h4>
<div class="boxContent">

    <g:hasErrors bean="${evaluationInstance}">
      <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <div class="graypanel">
      <div id="select-box">
        <p><g:message code="evaluation.linkToActivity"/></p>
        <g:formRemote name="formRemote" update="results" url="[controller: 'evaluation', action: 'searchMe']" before="showspinner('#results')">
          <g:textField class="datepicker-birthday" name="myDate" value="${formatDate(date: new Date(), format: 'dd. MM. yyyy')}"/>
          <g:submitButton name="submit" value="OK"/>
        </g:formRemote>
      </div>

      <div id="results"></div>
      <div id="selected" style="padding-top: 5px;"></div>
    </div>

    <g:formRemote update="content" name="formRemote" url="[action: 'update', id: evaluationInstance.id]">

      <g:hiddenField name="linkedentity" id="hiddenEntityId" value="0"/>

      <p><g:message code="linkedTo"/>: <g:if test="${evaluationInstance.linkedTo}"><erp:createLinkFromEvaluation linked="${evaluationInstance.linkedTo}"/></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></p>

      <p class="prop">
        <span class="name"><g:message code="title"/>: </span>
        <span class="value">
          <g:textField class="${hasErrors(bean: evaluationInstance, field: 'title', 'errors')}" size="60" name="title" value="${fieldValue(bean: evaluationInstance, field: 'title').decodeHTML()}"/>
        </span>
      </p>

      <p class="strong"><g:message code="description"/></p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
        <ckeditor:editor name="description" height="200px" toolbar="Basic">
          ${fieldValue(bean:evaluationInstance,field:'description').decodeHTML()}
        </ckeditor:editor>
      </span>

      <p class="strong"><g:message code="action"/></p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
        <ckeditor:editor name="method" height="200px" toolbar="Basic">
          ${fieldValue(bean:evaluationInstance,field:'method').decodeHTML()}
        </ckeditor:editor>
      </span>

      <div class="buttons cleared">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="Speichern"/></div>
        <g:link class="buttonGray" controller="clientProfile" action="show" id="${evaluationInstance.owner.id}" params="[ajax: 'showevaluation', ajaxId: evaluationInstance.id]"><g:message code="cancel"/></g:link>
      </div>

    </g:formRemote>

</div>