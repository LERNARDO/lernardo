<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ressource</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Ressource</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resource.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.fullName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resource.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.description')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resource.profile.type"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.type')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="resource.profile.classification"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: resource, field: 'profile.classification')}</td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${resource?.id}"><g:message code="edit"/></g:link>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
