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
    <h1><g:message code="groupActivity"/> "${project.profile.encodeAsHTML()}"</h1>
    <p class="gray"><g:message code="createdBy" args="[project.profile, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>
    <h2><g:message code="data"/></h2>
    <table>

      <tr class="prop">
        <td class="one"><g:message code="creator"/>:</td>
        <td class="two"><g:render template="/templates/creator" model="[entity: project]"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="projectTemplate"/>:</td>
        <td class="two">
          <g:if test="${template}">
            ${template.profile.encodeAsHTML()}
          </g:if>
          <g:else>
            <span class="italic"><g:message code="template.notAvailable"/></span>
          </g:else></td>
      </tr>

        <tr class="prop">
            <td class="one"><g:message code="begin"/></td>
            <td class="two"><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy" /></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="end"/></td>
            <td class="two"><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" /></td>
        </tr>

        <tr class="prop">
            <td class="one"><g:message code="description"/></td>
            <td class="two">${fieldValue(bean: project, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        %{--<tr class="prop">
            <td class="one"><g:message code="project.profile.educationalObjective"/></td>
            <td class="two">
                <g:if test="${project.profile.educationalObjective}">
                    <g:message code="goal.${project.profile.educationalObjective}"/>
                </g:if>
                <g:else>
                    <span class="italic"><g:message code="none"/></span>
                </g:else>
            </td>
        </tr>--}%

        <tr class="prop">
            <td class="one"><g:message code="project.profile.educationalObjectiveText"/></td>
            <td class="two">${fieldValue(bean: project, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <g:if test="${project.profile.completed}">
            <tr class="prop">
                <td class="one"><g:message code="project.objectiveReached"/></td>
                <td class="two"><g:formatBoolean boolean="${project.profile.objectiveReached}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
            </tr>

            <tr class="prop">
                <td class="one"><g:message code="project.objectiveComment"/></td>
                <td class="two">${fieldValue(bean: project, field: 'profile.objectiveComment').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>

            <tr class="prop">
                <td class="one"><g:message code="project.goodFactors"/></td>
                <td class="two">${fieldValue(bean: project, field: 'profile.goodFactors').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>

            <tr class="prop">
                <td class="one"><g:message code="project.badFactors"/></td>
                <td class="two">${fieldValue(bean: project, field: 'profile.badFactors').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>

            <tr class="prop">
                <td class="one"><g:message code="project.wouldRepeatIt"/></td>
                <td class="two"><g:formatBoolean boolean="${project.profile.wouldRepeatIt}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
            </tr>

            <tr class="prop">
                <td class="one"><g:message code="project.repeatReason"/></td>
                <td class="two">${fieldValue(bean: project, field: 'profile.repeatReason').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>
        </g:if>

    </table>

  </body>
</html>
