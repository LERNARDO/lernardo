<head>
  <meta name="layout" content="start"/>
  <title><g:message code="events"/></title>

    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "event", action: "remoteEvents", update: "events")}
            ${remoteFunction(controller: "event", action: "remoteNews", update: "news")}
        });
    </script>

</head>

<body>

<div class="yui3-g">

  <div class="yui3-u-1-2">
    <div class="boxHeader" style="padding-right: 20px;">
      <h1><g:message code="events"/></h1>
    </div>

    <div class="boxContent" style="padding-right: 20px;">
      <div class="second" id="events">

      </div>
    </div>
  </div>

  <div class="yui3-u-1-2">
    <div class="boxHeader">
      <h1><g:message code="newsp"/></h1>
    </div>

    <div class="boxContent">
      <div class="second" id="news">

      </div>
    </div>
  </div>

</div>

</body>