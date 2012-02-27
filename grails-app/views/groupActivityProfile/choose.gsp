<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'groupActivity')]"/></title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'groupActivity')]"/></h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form>

      <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">
        <g:message code="groupActivityTemplate"/> <g:message code="search"/>:<br/>

        <g:remoteField size="40" name="remoteField1" update="remoteTemplates" action="remoteTemplates" before="showspinner('#remoteTemplates')"/>
        <div id="remoteTemplates"></div>

        <div style="visibility: hidden">
          <g:textField name="template" id="hiddentextfield1" value=""/>
        </div>

        <div id="templates2">
          <span class="gray"><g:message code="groupActivityTemplate.choose"/></span>
        </div>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'groupActivity.plan')}"/></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}"/></div>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>