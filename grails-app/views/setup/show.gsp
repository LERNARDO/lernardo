<head>
  <meta name="layout" content="private"/>
  <title>ERP Setup</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1>ERP Setup</h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <div class="zusatz">
      <h5><g:message code="bloodTypes"/> <a onclick="clearElements(['#bloodTypeName']); toggle('#bloodTypes');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></h5>
      <div class="zusatz-add" id="bloodTypes" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'setup', action:'addBloodType', id: setupInstance.id]" update="bloodTypes2" before="showspinner('#bloodTypes2');" after="toggle('#bloodTypes');">
          <td><g:textField id="bloodTypeName" size="30" name="bloodType" value=""/></td>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="bloodTypes2">
        <g:render template="bloodTypes" model="[setupInstance: setupInstance]"/>
      </div>
    </div>

  </div>
</div>

