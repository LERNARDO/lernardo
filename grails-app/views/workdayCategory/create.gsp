<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.create" args="[message(code: 'workdayCategory')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'workdayCategory')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: workdayCategoryInstance]"/>
    <g:form>

      <div class="property">
        <g:message code="workdayCategory.name"/> <br/>
        <g:textField class="countable50 ${hasErrors(bean:workdayCategoryInstance,field:'name','errors')}" size="50" name="name" value="${fieldValue(bean:workdayCategoryInstance,field:'name').decodeHTML()}"/>
      </div>

      <div class="property">
        <g:message code="workdayCategory.count"/> <br/>
        <g:checkBox name="count" value="${fieldValue(bean:workdayCategoryInstance,field:'count')}"/>
      </div>

      <div class="clear"></div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>