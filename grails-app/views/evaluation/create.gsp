<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="evaluation.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="evaluation.create"/></h1>
  </div>
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
        <p>Mit Aktivitätsblock oder Projekteinheit verlinken:</p>
        <g:formRemote name="formRemote" update="results" url="[controller:'evaluation', action:'searchMe']" before="showspinner('#results')">
          <g:datePicker name="myDate" value="" precision="day" years="${2009..new Date().getYear() + 1900}"/>
          <g:submitButton name="submit" value="OK"/>
        </g:formRemote>
      </div>

      <div id="results"></div>
      <div id="selected" style="padding-top: 5px;"></div>
    </div>

    <g:form action="save" params="[entity:entity.id]">

      <div style="visibility: hidden">
        <g:textField name="linkedentity" id="hiddentextfield1" value="0"/>
      </div>

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

      <div class="buttons">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="${message(code:'save')}"/></div>
        <g:link class="buttonGray" action="list" id="${entity.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
