<%--
  Created by IntelliJ IDEA.
  User: Alexander Zeillinger
  Date: 04.01.2010
  Time: 13:03:56
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Administrator Verwaltung</title></head>
<body>
  <h2>Hortübersicht</h2>

  <h3>Gesamt: ${facilityList.size()}</h3>

  <div class="list">
    <ul>
      <g:each in="${facilityList}" var="facility">
        <li><g:link action="showFacility" params="[name:facility.name]">${facility.profile.fullName}</g:link></li>
      </g:each>
    </ul>
  </div>

</body>
</html>