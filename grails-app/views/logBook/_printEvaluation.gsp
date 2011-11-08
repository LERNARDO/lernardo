<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Logbuch</title>
    <style>
      @page {
        size: 297mm 210mm;
      }
      body {
          font-size: 12px;
      }
      .default-table {
          border-collapse: collapse;
          width: 100%;
      }
      .default-table td {
          padding: 10px 5px;
          /*border-bottom: 1px solid #9A9A9A;*/
          border-bottom: 1px solid #9a9a9a;
      } /*lighten(@button-gray, 20%); //#9a9a9a; //#eee;*/
      .default-table td a {
          text-decoration: none;
      }
      .default-table th {
          background: #9a9a9a; /*lighten(@button-gray, 5%); //#9A9A9A;*/
          /*border-bottom: 1px solid #787878;*/
          color: #fff;
          font-size: 11px;
          font-weight: bold;
          line-height: 17px;
          text-transform: uppercase;
          padding: 10px; /*2px 6px;*/
      }
      .default-table th a {
          color: #fff;
          display: block;
          font-size: 11px;
          text-decoration: none;
          width: 100%;
      }
      .default-table tr {
          font-size: 11px;
      }
      h2 {
        color: #44f;
        border-bottom: 1px solid #66f;
      }
      .gray {
        color: #aaa;
      }
      .one {
        font-weight: bold;
      }
      .green {
        color: #0a0;
      }
    </style>
  </head>
  <body>

  <h1>Logbuch von "${facility.profile.fullName}" vom Monat ${formatDate(date: logMonth.date, format: 'MMMM yyyy')}</h1>
  <p class="gray"><g:message code="createdBy" args="[currentEntity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>

  <h2>Übersicht</h2>
  <erp:renderLogMonthPrint logMonth="${logMonth}" facility="${facility}" date="${date}"/>

  <h2>Details (Teilnahmen)</h2>
  <erp:renderLogMonthEntries facility="${facility}" date="${date}"/>

  </body>
</html>