<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="groupActivity"/></title>
    <style>
      @page {
        <erp:setPageFormat format="${pageformat}"/>
      }
      body {
          font-size: 12px;
      }
      .default-table th {
        border-bottom: 1px solid #000;
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
      .italic {
        font-style: italic;
      }
    </style>
  </head>
  <body>
    <h1><g:message code="projectTemplate"/> "${template.profile.encodeAsHTML()}"</h1>
    <p class="gray"><g:message code="createdBy" args="[template.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="creator"/>:</td>
        <td class="two"><g:render template="/templates/creator" model="[entity: template]"/></td>
      </tr>

        <tr class="prop">
            <td class="one"><g:message code="status"/>:</td>
            <td class="two"><g:message code="status.${template.profile.status}"/></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="description"/>:</td>
            <td class="two">${fieldValue(bean: template, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="projectTemplate.profile.educationalObjectiveText"/>:</td>
            <td class="two">${fieldValue(bean: template, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
            <td class="two">${template?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.ageTo"/></td>
            <td class="two">${template?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

    </table>

  </body>
</html>
