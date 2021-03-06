<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="timeEvaluation"/></title>
    <style>
      @page {
        <erp:setPageFormat format="${pageformat}"/>
      }
      body {
          font-size: 12px;
      }
      table {
        border-collapse: collapse;
      }
      th {
        background: #cc5;
        padding: 2px;
        border: 1px solid #aa3;
      }
      td {
        background: #eee;
        padding: 2px;
        border: 1px solid #999;
      }
      h2 {
        color: #44f;
        border-bottom: 1px solid #66f;
      }
      .bold {
        font-weight: bold;
      }
      .unit {
        border: 1px solid #ccc;
        padding: 5px;
        margin-bottom: 5px;
      }
      .gray {
        color: #aaa;
      }
    </style>
  </head>
  <body>

    <h1><g:message code="timeEvaluation"/></h1>
    <p class="gray"><g:message code="from"/> <span class="bold">${entity.profile}</span> <g:message code="forDateRange"/></p>
    <h2><g:formatDate date="${date1}" format="dd.MM.yyyy"/> <g:message code="to"/> <g:formatDate date="${date2}" format="dd.MM.yyyy"/></h2>

    <erp:timeRecordingReport entity="${entity}" date1="${date1}" date2="${date2}"/>

  </body>
</html>
