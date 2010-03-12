<head>
  <title>Lernardo | Hilfethemen</title>
  <meta name="layout" content="private"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Hilfethemen ${helperFor}</h1>
  </div>
<div class="boxGray">

    <div id="newHelper">
      <app:isAdmin><g:link class="buttonBlue" action="create" params="[entity:entity.id]">Neues Thema anlegen</g:link></app:isAdmin>
    </div>

    <g:if test="${helperInstanceList.size() > 0}">
      <p>Es gibt insgesamt ${helperInstanceList.size()} Hilfethemen für "${entity.type.name}".</p>
    </g:if>
    <g:else>
      <p>Keine Hilfethemen vorhanden.</p>
    </g:else>

    <ul>
    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <li><a href="#${i}">${helperInstance.title}</a></li>
    </g:each>
    </ul>

    <g:each in="${helperInstanceList}" status="i" var="helperInstance">
      <p><a name="${i}">${helperInstance.title}</a><app:isAdmin><g:link class="helperButton" action="edit" id="${helperInstance.id}" params="[entity:entity.id]">bearbeiten</g:link></app:isAdmin><br/>
      ${helperInstance.content.decodeHTML()}</p>
    </g:each>

</div>
</body>
