<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="change.pwd"/></title>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="change.pwd"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="yui-g" id="settings">
      <div class="settings-block-content">
        <g:form controller="profile" action="checkPassword" id="${entity.id}">
          <table cellpadding="0" cellspacing="0" border="0" id="settings-table">
            <tr>
              <td class="topic"><g:message code="change.pwd.new"/>:</td>
              <td><g:passwordField name="password"/></td>
            </tr>
            <tr>
              <td class="topic"><g:message code="change.pwd.new2"/>:</td>
              <td><g:passwordField name="password2"/></td>
            </tr>
            <tr>
              <td>
                <g:submitButton name="checkPassword" value="${message(code:'save')}"/>
                <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}"><g:message code="cancel"/></g:link>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </g:form>
      </div>
    </div>
  </div>
</div>
</body>