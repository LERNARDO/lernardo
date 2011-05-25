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
        <g:formRemote name="formRemote" url="[controller:'setup', action:'addElement', id: setupInstance.id, params: [type: 'bloodTypes']]" update="bloodTypes2" before="showspinner('#bloodTypes2');" after="toggle('#bloodTypes');">
          <g:textField id="bloodTypeName" size="30" name="elementName" value=""/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="bloodTypes2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'bloodTypes']"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="nationalities"/> <a onclick="clearElements(['#nationalityName']); toggle('#nationalities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></h5>
      <div class="zusatz-add" id="nationalities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'setup', action:'addElement', id: setupInstance.id, params: [type: 'nationalities']]" update="nationalities2" before="showspinner('#nationalities2');" after="toggle('#nationalities');">
          <g:textField id="nationalityName" size="30" name="elementName" value=""/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="nationalities2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'nationalities']"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="languages"/> <a onclick="clearElements(['#languageName']); toggle('#languages');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></h5>
      <div class="zusatz-add" id="languages" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'setup', action:'addElement', id: setupInstance.id, params: [type: 'languages']]" update="languages2" before="showspinner('#languages2');" after="toggle('#languages');">
          <g:textField id="languageName" size="30" name="elementName" value=""/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="languages2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'languages']"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="schoolLevels"/> <a onclick="clearElements(['#schoolLevelName']); toggle('#schoolLevels');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></h5>
      <div class="zusatz-add" id="schoolLevels" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'setup', action:'addElement', id: setupInstance.id, params: [type: 'schoolLevels']]" update="schoolLevels2" before="showspinner('#schoolLevels2');" after="toggle('#schoolLevels');">
          <g:textField id="schoolLevelName" size="30" name="elementName" value=""/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="schoolLevels2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'schoolLevels']"/>
      </div>
    </div>

  </div>
</div>
</body>

