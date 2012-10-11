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
    <h1><g:message code="template"/> "${template.profile.encodeAsHTML()}"</h1>
    <p class="gray"><g:message code="createdBy" args="[template.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="creator"/>:</td>
        <td class="two"><g:render template="/templates/creator" model="[entity: template]"/></td>
      </tr>

        <tr class="prop">
            <td class="one"><g:message code="duration"/></td>
            <td class="two">${template.profile.duration} <g:message code="minutes"/></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.socialForm"/></td>
            <td class="two"><g:message code="socialForm.${template.profile.socialForm}"/></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="status"/></td>
            <td class="two"><g:message code="status.${template.profile.status}"/></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.amountEducators"/></td>
            <td class="two">${template.profile.amountEducators}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="description"/></td>
            <td class="two">${template.profile.description.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.chosenMaterials"/></td>
            <td class="two">${template.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
            <td class="two">${template?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.ageTo"/></td>
            <td class="two">${template?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="activityTemplate.goal"/></td>
            <td class="two">${template?.profile?.goal?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

    </table>

  </body>
</html>
