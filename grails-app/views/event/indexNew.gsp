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
    <li class="redbox"><g:link controller="educatorProfile" action="index" onclick="showBigSpinner()" onmouseover="jQuery('#reddescription').show();" onmouseout="jQuery('#reddescription').hide();">${message(code: 'database').toUpperCase()}</g:link></li>
    <li class="greenbox"><g:link controller="logBook" action="entries" onclick="showBigSpinner()" onmouseover="jQuery('#greendescription').show();" onmouseout="jQuery('#greendescription').hide();">${message(code: 'organisation').toUpperCase()}</g:link></li>
    <li class="bluebox"><g:link controller="templateProfile" action="index" onclick="showBigSpinner()" onmouseover="jQuery('#bluedescription').show();" onmouseout="jQuery('#bluedescription').hide();">${message(code: 'planning').toUpperCase()}</g:link></li>
    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <li class="yellowbox"><g:link controller="setup" action="show" onclick="showBigSpinner()" onmouseover="jQuery('#yellowdescription').show();" onmouseout="jQuery('#yellowdescription').hide();">${message(code: 'administration').toUpperCase()}</g:link></li>
    </erp:accessCheck>
  </ul>

  <div class="clear"></div>

  <div id="descriptions">
    <div class="description" id="reddescription" style="display: none;">
      <p class="bold"><g:message code="database"/></p>
      <p>In der Datenbank hast du die Möglichkeit, verschiedene Profile wie PädagogInnen,
      Betreute, Erziehungsberechtigte etc. zu erstellen bzw. einzusehen. Weiters kannst du
      hier verschiedene Betreutengruppen und Familien anlegen und so umfassende Daten zu
      deinen Betreuten sammeln.</p>
    </div>

    <div class="description" id="greendescription" style="display: none;">
      <p class="bold"><g:message code="organisation"/></p>
      <p>Im Menüpunkt Organisation kannst du regelmäßig wiederkehrende Abläufe wie
      Anwesenheit der Betreuten und Teilnahme am Mittagessen dokumentieren,
      mit Kosten versehen und auswerten. Dies erleichtert die Verrechnung mit den
      Erziehungsberechtigten, die ebenfalls in diesem Bereich dokumentiert werden kann.</p>
    </div>

    <div class="description" id="bluedescription" style="display: none;">
      <p class="bold"><g:message code="planning"/></p>
      <p>Hier kannst du dir Anregungen zu den verschiedensten Aktivitäten und Projekten holen,
      Vorlagen anlegen und natürlich auch selbst Aktivitäten planen. Zudem hast du die
      Möglichkeit, bereits angelegte Vorlagen zu kommentieren und für deinen Zweck individuell
      anzupassen.</p>
    </div>

    <div class="description" id="yellowdescription" style="display: none;">
      <p class="bold"><g:message code="administration"/></p>
      <p>Dieser Bereich richtet sich vor allem an den bzw. die Betreiber. Unter „Setup“ kannst
      du verschiedene Voreinstellungen wie Sprachen, Nationalitäten, Schulstufen,
      Arbeitsbeschreibungen etc. anlegen, die für die Datenbank sinnvoll erscheinen. Um den
      Aktivitätenpool sinnvoll strukturieren zu können, hast du als Betreiber hier die Möglichkeit,
      Bewertungsmethoden und Labels festzulegen.</p>
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