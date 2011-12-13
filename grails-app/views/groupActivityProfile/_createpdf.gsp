<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
    <h1><g:message code="groupActivity"/> "${group.profile.fullName.encodeAsHTML()}"</h1>
    <p class="gray"><g:message code="createdBy" args="[entity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="creator"/>:</td>
        <td class="two"><g:render template="/templates/creator" model="[entity: group]"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivityTemplate"/>:</td>
        <td class="two">
          <g:if test="${template}">
            ${template.profile.fullName.encodeAsHTML()}
          </g:if>
          <g:else>
            <span class="italic"><g:message code="template.notAvailable"/></span>
          </g:else></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="groupActivity.profile.realDuration"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="date"/>:</td>
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
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

    </table>

    <h2><g:message code="activities"/></h2>
    <ul>
      <g:each in="${activities}" var="activity">
        <li>${activity.profile.fullName.encodeAsHTML()} (${activity.profile.duration} min)</li>
      </g:each>
    </ul>

    <h2><g:message code="themes"/></h2>
    <g:if test="${themes}">
      <ul>
        <g:each in="${themes}" var="theme">
          <li>${theme.profile.fullName.encodeAsHTML()}</li>
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
          <li>${facility.profile.fullName.encodeAsHTML()}</li>
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
        <li>${educator.profile.fullName.encodeAsHTML()}</li>
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
        <li>${substitute.profile.fullName.encodeAsHTML()}</li>
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
        <li>${client.profile.fullName.encodeAsHTML()}</li>
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
        <li>${parent.profile.fullName.encodeAsHTML()}</li>
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
        <li>${partner.profile.fullName.encodeAsHTML()}</li>
      </g:each>
    </ul>
    </g:if>
    <g:else>
      <span class="italic">${message(code:'noData')}</span>
    </g:else>

    <g:if test="${withTemplates == 'true'}">
      <h2><g:message code="activities"/></h2>
      <g:each in="${activities}" var="activity">

        <table style="border-bottom: 1px solid #ccc; padding-bottom: 10px;">

          <tr class="prop">
            <td class="one"><g:message code="activityTemplate"/>:</td>
            <td class="two">${activity.profile.fullName.encodeAsHTML()}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="creator"/>:</td>
            <td class="two"><g:render template="/templates/creator" model="[entity: activity]"/></td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="duration"/>:</td>
            <td class="two">${fieldValue(bean: activity, field: 'profile.duration')} min</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="activityTemplate.socialForm"/>:</td>
            <td class="two"><g:message code="socialForm.${activity.profile.socialForm}"/></td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="activityTemplate.amountEducators"/>:</td>
            <td class="two">${activity.profile.amountEducators}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="activityTemplate.chosenMaterials"/>:</td>
            <td class="two">${activity.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="resources.required"/>:</td>
            <td class="two">
              <g:if test="${activity.profile.resources}">
                <g:each in="${activity.profile.resources}" var="resource">
                  <div style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc;">
                    <ul>
                      <li><span class="bold"><g:message code="name"/>:</span> ${resource.name.encodeAsHTML()}</li>
                      <li><g:message code="description"/>: ${resource.description.decodeHTML() ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
                      <li><g:message code="resource.profile.amount"/>: ${resource.amount}</li>
                    </ul>
                  </div>
                </g:each>
              </g:if>
              <g:else>
                <span class="italic red"><g:message code="resource.profile.empty"/></span>
              </g:else>
            </td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="description"/>:</td>
            <td class="two">${fieldValue(bean: activity, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td class="one"><g:message code="vMethods"/>:</td>
            <td class="two">
              <g:if test="${activity.profile.methods}">
                <g:each in="${activity.profile.methods}" var="method">
                  <ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc;">
                    <li><span class="bold">${method.name.encodeAsHTML()}</span></li>
                    <li>${method.description.decodeHTML()}</li>
                    %{--<g:each in="${method.elements}" var="element">
                      <li>${element.name} <div id="starBox${element.id}" class="starbox">--}%%{--<erp:starBox element="${element.id}" template="${activity}"/>--}%%{--</div></li>
                    </g:each>--}%
                  </ul>
                </g:each>
              </g:if>
              <g:else>
                <span class="italic red"><g:message code="vMethods.empty"/></span>
              </g:else>
            </td>
          </tr>

        </table>

      </g:each>

    </g:if>

  </body>
</html>
