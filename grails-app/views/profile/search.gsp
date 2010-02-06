<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Profilsuche</title>
    <g:javascript library="jquery"/>
  </head>
  <body>
  <div class="headerBlue">
  <h1>Profilsuche</h1>
</div>
  <div class="boxGray">
    <div id="body-list">
      <g:formRemote name="searchForm" url="[controller:'profile', action:'searchMe']" class="members-filter" update="membersearch-results">
      <fieldset>
        <div class="form-content">
          <div>
            <label for="name">Bitte einen Namen eingeben:</label>
            <input id="name" type="text" name="name"/>            
          </div>
          <div class="buttons">
            <g:submitButton name="button" value="Suchen"/>
          </div>
        </div>
      </fieldset>
    </g:formRemote>

    <div class="membersearch-results" id="membersearch-results">
    </div>
   </div>
    </div>
  </body>
</html>