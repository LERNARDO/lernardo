<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Suche</title>
    <g:javascript library="jquery"/>
  </head>
  <body>
    <div id="body-list">
      <h1>Mitgliedersuche</h1>
      <g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
      <fieldset>
        <div class="form-content">
          <div class="search-field">
            <label for="name">Bitte einen Namen eingeben:</label>
            <input id="name" type="text" name="name"/>
            <g:submitButton name="button" value="Suchen"/>
          </div>
        </div>
      </fieldset>
    </g:formRemote>

    <div class="membersearch-results" id="membersearch-results">
    </div>
   </div>
  </body>
</html>