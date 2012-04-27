<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="profile"/> - ${methodInstance.name}</title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="profile"/> - ${methodInstance.name}</h1>
</div>
<div class="boxGray">
  <div class="second">

    <table>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: methodInstance, field: 'name').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: methodInstance, field: 'description').decodeHTML() ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
      </tr>

    </table>

    <div class="buttons">
      <g:form id="${methodInstance.id}">
        <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
      </g:form>
      <div class="clear"></div>
    </div>

    <div class="zusatz">
      <h5>Elemente <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#elements'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}" /></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="elements" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'method', action:'addElement', id:methodInstance.id]" update="elements2" before="showspinner('#elements2')" after="clearElements(['#hide'])">
          Bezeichnung: <g:textField id="hide" name="name" size="40"/>
          <div class="clear"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="clear"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="elements2">
        <g:render template="elements" model="[methodInstance: methodInstance]"/>
      </div>
    </div>

  </div>
</div>
</body>