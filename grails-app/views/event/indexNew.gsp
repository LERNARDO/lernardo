<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="start"/>
  <title><g:message code="events"/></title>

  <script type="text/javascript">
      $(function() {
        ${remoteFunction(controller:"event", action: "remoteEvents", update: "events", before: "showspinner('#events')")}
        ${remoteFunction(controller:"event", action: "remoteNews", update: "news", before: "showspinner('#news')")}
      });
    </script>

</head>

<body>

<div id="welcome">
  <div id="head">
    <span style="color: #aaa;">Willkommen im</span> ERPEL
  </div>

  <ul id="boxes">
    <li class="redbox"><g:link controller="educatorProfile" action="index" onclick="showBigSpinner()" onmouseover="jQuery('#reddescription').show();" onmouseout="jQuery('#reddescription').hide();">DATENBANK</g:link></li>
    <li class="greenbox"><g:link controller="logBook" action="entries" onclick="showBigSpinner()" onmouseover="jQuery('#greendescription').show();" onmouseout="jQuery('#greendescription').hide();">ORGANISATION</g:link></li>
    <li class="bluebox"><g:link controller="templateProfile" action="index" onclick="showBigSpinner()" onmouseover="jQuery('#bluedescription').show();" onmouseout="jQuery('#bluedescription').hide();">PLANUNG</g:link></li>
    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <li class="yellowbox"><g:link controller="setup" action="show" onclick="showBigSpinner()" onmouseover="jQuery('#yellowdescription').show();" onmouseout="jQuery('#yellowdescription').hide();">ADMINISTRATION</g:link></li>
    </erp:accessCheck>
  </ul>

  <div class="clear"></div>

  <div id="descriptions">
    <div class="description" id="reddescription" style="display: none;">
      <p class="bold">Datenbank</p>
      <p>Text zu Datenbank</p>
    </div>

    <div class="description" id="greendescription" style="display: none;">
      <p class="bold">Organisation</p>
      <p>Text zu Organisation</p>
    </div>

    <div class="description" id="bluedescription" style="display: none;">
      <p class="bold">Planung</p>
      <p>Text zu Planung</p>
    </div>

    <div class="description" id="yellowdescription" style="display: none;">
      <p class="bold">Administration</p>
      <p>Text zu Administration</p>
    </div>
  </div>

</div>


<div class="yui3-g">

  <div class="yui3-u-1-2">
    <div class="boxHeader" style="padding-right: 20px;">
      <div class="second">
        <h1><g:message code="events"/></h1>
      </div>
    </div>

    <div class="boxGray" style="padding-right: 20px;">
      <div class="second" id="events">

      </div>
    </div>
  </div>

  <div class="yui3-u-1-2">
    <div class="boxHeader">
      <div class="second">
        <h1><g:message code="newsp"/></h1>
      </div>
    </div>

    <div class="boxGray">
      <div class="second" id="news">

      </div>
    </div>
  </div>

</div>

</body>