<%--
  Created by IntelliJ IDEA.
  User: mkuhl
  Date: 26.09.2009
  Time: 14:55:40
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>FullCalendar Minimum</title>
    <meta name="layout" content="private" />

    <g:javascript library="jquery" />
    <g:javascript src="jquery/jquery.fullcalendar.js"/>
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.fullcalendar.css')}" />
  </head>

  <body>
    <jq:jquery>
      console.info ("starting calendar init");
      $('#calendar').fullCalendar({
        header: { left:'title', center:'month basicWeek basicDay', right:'prev,next' },
        aspectRatio: 2.2
      })

    </jq:jquery>

      <div id="calendar">
    </div>
  </body>
</html>