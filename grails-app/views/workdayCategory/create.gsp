<head>
  <meta name="layout" content="private"/>
  <title><g:message code="workdayCategory.create"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="workdayCategory.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: workdayCategoryInstance]"/>
    <g:form action="save">

      <div class="property">
        <g:message code="workdayCategory.name"/> <br/>
        <g:textField class="countable50 ${hasErrors(bean:workdayCategoryInstance,field:'name','errors')}" size="50" name="name" value="${fieldValue(bean:workdayCategoryInstance,field:'name').decodeHTML()}"/>
      </div>

      <div class="clear"></div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>