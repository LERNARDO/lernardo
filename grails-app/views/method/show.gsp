<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${methodInstance.name}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${methodInstance.name}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="method.name"/>:
          </td>
           <td valign="top" class="name-show">
            <g:message code="method.description"/>:
          </td>

        </tr>

        <tr class="prop">
         <td width="280" valign="top" class="value-show">${fieldValue(bean: methodInstance, field: 'name').decodeHTML()}</td>
          <td width="480" valign="top" class="value-show-block">${fieldValue(bean: methodInstance, field: 'description').decodeHTML()}</td>
        </tr>

        </tbody>
      </table>
    </div>

    %{--<erp:isMeOrAdmin entity="${operator}">--}%
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${methodInstance?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" id="${methodInstance.id}">><g:message code="delete"/></g:link>
        <div class="spacer"></div>
      </div>
    %{--</erp:isMeOrAdmin>--}%

    <div class="zusatz">
      <h5>Elemente <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#elements'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Element hinzufügen" /></a></erp:isOperator></h5>
      <div class="zusatz-add" id="elements" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'method', action:'addElement', id:methodInstance.id]" update="elements2" before="showspinner('#elements2')" after="cleartext()">
          Bezeichnung: <g:textField id="hide" name="name" size="40"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="elements2">
        <g:render template="elements" model="[methodInstance: methodInstance, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>