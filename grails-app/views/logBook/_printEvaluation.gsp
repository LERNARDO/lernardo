<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="logBook"/></title>
    <style>
      @page {
        <erp:setPageFormat format="${pageformat}"/>
      }
      body {
          font-size: 12px;
      }
      .default-table {
          border-collapse: collapse;
          width: 100%;
      }
      .default-table td {
          padding: 2px;
          border-bottom: 1px solid #9a9a9a;
          border-right: 1px solid #9a9a9a;
      }
      .default-table td a {
          text-decoration: none;
      }
      .default-table th {
          background: #9a9a9a;
          color: #fff;
          font-size: 11px;
          font-weight: bold;
          line-height: 17px;
          text-transform: uppercase;
          padding: 10px;
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
      .bold {
        font-weight: bold;
      }
      .italic {
        font-style: italic;
      }
      .clear {
        clear: both;
      }
    </style>
  </head>
  <body>

  <h1><g:message code="logBook.ofFrom" args="[facility.profile, formatDate(date: logMonth.date, format: 'MMMM yyyy')]"/></h1>
  <p class="gray"><g:message code="createdBy" args="[currentEntity.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>

  <h2><g:message code="profile.overview"/></h2>
  <erp:renderLogMonthPrint logMonth="${logMonth}" facility="${facility}" date="${date}"/>

  <h2><g:message code="logBook.details"/></h2>
  <erp:renderLogMonthEntries facility="${facility}" date="${date}"/>

  </body>
</html>