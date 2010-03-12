<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profilsuche</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Mitgliederübersicht</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second" id="userlist-results">
    <p>Bitte eine Auswahl treffen!</p>
    <g:render template="glossary" model="[glossary: glossary]"/>
  </div>
</div>

<div class="headerBlue">
  <div class="second">
    <h1>Mitgliedersuche</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div id="body-list">
      <g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
        <fieldset>
          <div class="form-content">
            <div>
              <label for="name">Bitte einen Namen eingeben:</label>
              <input id="name" type="text" name="name"/>
            </div>
            <div class="buttons" style="padding-bottom: 5px">
              <g:submitButton name="button" value="Suchen"/>
              <div class="clear"></div>
            </div>
          </div>
        </fieldset>
      </g:formRemote>

      <div class="membersearch-results" id="membersearch-results">
      </div>

    </div>
  </div>
</div>
</body>