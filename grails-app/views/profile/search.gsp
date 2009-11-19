<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Suche</title>
    <g:javascript library="jquery"/>
  </head>
  <body>
    <div id="body-list">
      <h2>Suche</h2>
      <g:formRemote name="searchForm" url="[action:'searchMe']" class="members-filter" update="membersearch-results">
      <fieldset>
        <legend>Mitgliedersuche</legend>
        <div class="form-content">
          <div class="search-field">
            <label for="name">Nach Mitgliedern suchen:</label>
            <input id="name" type="text" name="name"/>
            <input id="button" type="submit" name="button" value="Suchen" />
          </div>
        </div>
      </fieldset>
    </g:formRemote>

    <div class="membersearch-results" id="membersearch-results">
    </div>
   </div>
  </body>
</html>