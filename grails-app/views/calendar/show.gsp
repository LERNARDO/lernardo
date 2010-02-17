<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Hortkalender</title>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
    <g:javascript src="jquery/fullcalendar-1.4.4.js"/>
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'fullcalendar-1.4.4.css')}" />
    <g:render template="/templates/calendar" model="[name:name]"/>

  </head>

  <body>
  <div class="boxGray">
      <div class="profile-group" style="width:250px;">Lernardo - Gesamt</div>
      <div class="profile-box">
        <div id="profile-content"></div>
      </div>
    </div>
  </body>
</html>