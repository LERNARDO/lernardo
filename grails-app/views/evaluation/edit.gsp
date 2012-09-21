<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="database"/>
  <title><g:message code="evaluation.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="evaluation.edit"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${evaluationInstance}">
      <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <div style="background: #fefefe; border: 1px solid #ccc; border-radius: 5px; padding: 10px;">
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

    <g:form action="update" id="${evaluationInstance.id}" params="[name:entity.name]">

      <div style="visibility: hidden">
        <g:textField name="linkedentity" id="hiddentextfield1" value="0"/>
      </div>

      <p><g:message code="linkedTo"/>: <g:if test="${evaluationInstance.linkedTo}"><erp:createLinkFromEvaluation evaluation="${evaluationInstance}"/></g:if><g:else><span class="italic"><g:message code="links.notLinked"/></span></g:else></p>

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
        <g:link class="buttonGray" action="show" id="${evaluationInstance.id}" params="[entity: entity.id]"><g:message code="cancel"/></g:link>
      </div>

    </g:form>
  </div>
</div>
</body>
