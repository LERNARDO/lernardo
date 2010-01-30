<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Hilfethemen</title>
  <g:javascript library="jquery"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Hilfethemen für ${helperFor}</h1>
  </div>
<div class="boxGray">

    <div id="newHelper">
      <ub:isAdmin entity="entity"><g:link class="buttonBlue" action="create" params="[name:entity.name]">Neues Thema anlegen</g:link></ub:isAdmin>
    </div>

    <p>Es gibt insgesamt ${helperInstanceList.size()} Hilfethemen für ${helperFor}.</p>

    <ul>
    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <li><a href="#${i}">${helperInstance.title}</a></li>
    </g:each>
    </ul>

    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <p><a name="${i}">${helperInstance.title}</a><ub:isAdmin entity="entity"><g:link class="helperButton" action="edit" id="${helperInstance.id}" params="[name:entity.name]">bearbeiten</g:link></ub:isAdmin><br/>
      ${helperInstance.content.decodeHTML()}</p>
    </g:each>

</div>
</body>
