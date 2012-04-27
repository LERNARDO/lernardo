<head>
  <meta name="layout" content="database"/>
  <title><g:message code="change.pwd"/></title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="change.pwd"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${error}">
      <p class="italic red">Bitte Passwort 2x identisch eingeben!</p>
    </g:if>

    <g:form controller="profile" action="checkPassword" id="${entity.id}">
      <table>
        <tr style="line-height: 30px">
          <td><g:message code="change.pwd.new"/>:</td>
          <td><g:passwordField name="password"/></td>
        </tr>
        <tr style="line-height: 30px">
          <td><g:message code="change.pwd.new2"/>:</td>
          <td><g:passwordField name="password2"/></td>
        </tr>
      </table>

      <div class="buttons">
        <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}"><g:message code="cancel"/></g:link></div>
        <div class="clear"></div>
      </div>

    </g:form>

  </div>
</div>
</body>