<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${methodInstance.name}</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${methodInstance.name}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
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

    %{--<app:isMeOrAdmin entity="${operator}">--}%
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${methodInstance?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    %{--</app:isMeOrAdmin>--}%

    <div class="zusatz">
      <h5>Elemente <app:isMeOrAdmin entity="${partner}"><a href="#" id="show-elements"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Element hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-elements" targetId="elements"/>
      </jq:jquery>
      <div class="zusath-add" id="elements" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'method', action:'addElement', id:methodInstance.id]" update="elements2" before="hideform('#elements')" after="cleartext()">
          Bezeichnung: <g:textField id="hide" name="name" size="40"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="elements2">
        <g:render template="elements" model="${methodInstance}"/>
      </div>
    </div>

  </div>
</div>
</body>