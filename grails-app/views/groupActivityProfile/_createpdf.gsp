<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="groupActivity"/></title>
    <style>
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
    <h1><g:message code="groupActivity"/> "${group.profile.fullName}"</h1>
    <p class="gray"><g:message code="createdBy" args="[entity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="creator"/>:</td>
        <td class="two"><g:render template="/templates/creator" model="[entity: group]"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivityTemplate"/>:</td>
        <td class="two">${template.profile.fullName}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.realDuration"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.date"/>:</td>
        <td class="two"><g:formatDate date="${group?.profile?.date}" format="dd. MMMM yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.educationalObjectiveText"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.educationalObjective"/>:</td>
        <td class="two">
          <g:if test="${group.profile.educationalObjective}">
            <g:message code="goal.${group.profile.educationalObjective}"/>
          </g:if>
          <g:else>
            <span class="italic"><g:message code="none"/></span>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.description"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

    </table>

    <g:if test="${activities}">
      <h2><g:message code="activities"/></h2>
        <ul>
          <g:each in="${activities}" var="activity">
            <li>${activity.profile.fullName} (${activity.profile.duration} min)</li>
          </g:each>
        </ul>
    </g:if>

    <h2><g:message code="themes"/></h2>
    <g:if test="${themes}">
      <ul>
        <g:each in="${themes}" var="theme">
          <li>${theme.profile.fullName}</li>
        </g:each>
      </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="facility"/></h2>
    <g:if test="${facilities}">
      <ul>
        <g:each in="${facilities}" var="facility">
          <li>${facility.profile.fullName}</li>
        </g:each>
      </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="educators"/></h2>
    <g:if test="${educators}">
      <ul>
      <g:each in="${educators}" var="educator">
        <li>${educator.profile.fullName}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="substitutes"/></h2>
    <g:if test="${substitutes}">
      <ul>
      <g:each in="${substitutes}" var="substitute">
        <li>${substitute.profile.fullName}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="clients"/></h2>
    <g:if test="${clients}">
      <ul>
      <g:each in="${clients}" var="client">
        <li>${client.profile.fullName}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="parents"/></h2>
    <g:if test="${parents}">
      <ul>
      <g:each in="${parents}" var="parent">
        <li>${parent.profile.fullName}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <h2><g:message code="partner"/></h2>
    <g:if test="${partners}">
      <ul>
      <g:each in="${partners}" var="partner">
        <li>${partner.profile.fullName}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

  </body>
</html>
