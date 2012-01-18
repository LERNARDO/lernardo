<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="database"/>
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

    <div style="background: #eee; padding: 10px; margin: 0 0 10px 0;">
      <div id="select-box">
        <p><g:message code="evaluation.linkToActivity"/></p>
        <g:formRemote name="formRemote" update="results" url="[controller:'evaluation', action:'searchMe']" before="showspinner('#results')">
          <g:textField class="datepicker-birthday" name="myDate" value=""/>
          <g:submitButton name="submit" value="OK"/>
        </g:formRemote>
      </div>

      <div id="results"></div>
      %{--<div id="selected" style="padding-top: 5px;"></div>--}%
    </div>

    <g:form action="save" params="[entity:entity.id]">

      <p class="gray">
        <g:message code="linkedTo"/><br/>
        <g:if test="${target}">
          <g:select name="linkedentity" id="hiddenselect" from="[target]" optionKey="id" optionValue="profile" value="${target?.id}"/>
        </g:if>
        <g:else>
          <g:select name="linkedentity" id="hiddenselect" />
        </g:else>
      </p>

      <p class="gray"><g:message code="description"/><br/>
        <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
          <ckeditor:editor name="description" height="200px" toolbar="Basic">
            ${fieldValue(bean:evaluationInstance,field:'description').decodeHTML()}
          </ckeditor:editor>
        </span>
      </p>

      <p class="gray"><g:message code="action"/><br/>
        <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
          <ckeditor:editor name="method" height="200px" toolbar="Basic">
            ${fieldValue(bean:evaluationInstance,field:'method').decodeHTML()}
          </ckeditor:editor>
        </span>
      </p>

      <div class="buttons">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="${message(code:'save')}"/></div>
        <g:link class="buttonGray" action="list" id="${entity.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
