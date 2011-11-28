<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="start"/>
  <title><g:message code="events"/></title>
</head>

<body>

<div id="welcome">
  <div id="head">
    <span style="color: #aaa;">Willkommen im</span> ERPEL
  </div>

  <ul id="boxes">
    <li class="redbox"><g:link controller="dummy" onmouseover="jQuery('#reddescription').show();" onmouseout="jQuery('#reddescription').hide();">DATENBANK</g:link></li>
    <li class="greenbox"><g:link controller="dummy" onmouseover="jQuery('#greendescription').show();" onmouseout="jQuery('#greendescription').hide();">ORGANISATION</g:link></li>
    <li class="bluebox"><g:link controller="dummy" onmouseover="jQuery('#bluedescription').show();" onmouseout="jQuery('#bluedescription').hide();">PLANUNG</g:link></li>
    <li class="yellowbox"><g:link controller="dummy" onmouseover="jQuery('#yellowdescription').show();" onmouseout="jQuery('#yellowdescription').hide();">ADMINISTRATION</g:link></li>
  </ul>

  <div class="clear"></div>

  <div id="descriptions">
    <div class="description" id="reddescription" style="display: none;">
      <p class="bold">Datenbank</p>
      <p>Text zu Datenbank</p>
    </div>

    <div class="description" id="greendescription" style="display: none;">
      <p class="bold">Organisation</p>
      <p>Text zu Organisation</p>
    </div>

    <div class="description" id="bluedescription" style="display: none;">
      <p class="bold">Planung</p>
      <p>Text zu Planung</p>
    </div>

    <div class="description" id="yellowdescription" style="display: none;">
      <p class="bold">Administration</p>
      <p>Text zu Administration</p>
    </div>
  </div>

</div>


<div class="yui3-g">

  <div class="yui3-u-1-2">
    <div class="boxHeader">
      <div class="second">
        <h1><g:message code="events"/></h1>
      </div>
    </div>

    <div class="boxGray">
      <div class="second">

        <g:if test="${events}">
          <table class="default-table">
            <tbody>
            <erp:getBirthdays>
              <g:if test="${entities}">
                <g:each in="${entities}" var="entity">
                  <tr>
                    <td style="width: 40px;">
                      <erp:profileImage entity="${entity}" width="30" style="vertical-align: middle;"/>
                    </td>
                    <td class="gray">
                      <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]"><span
                          class="bold">${entity.profile.fullName}</span></g:link> hat heute Geburtstag! <img src="${resource(dir: 'images/icons', file: 'icon_cake.png')}" alt="Birthday"
                                                                                                             style="position: relative; top: 3px; margin-right: 5px;"/>
                    </td>
                  </tr>
                </g:each>
              </g:if>
            </erp:getBirthdays>
            <g:each in="${events}" status="i" var="event">
              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td style="width: 40px;">
                  <erp:profileImage entity="${Entity.get(event.who)}" width="30" style="vertical-align: middle;"/>
                </td>
                <td class="gray">
                  <g:formatDate date="${event.date}" format="EE dd. MMM. yyyy - HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
                  <erp:getEvent event="${event}"/> <erp:isSystemAdmin entity="${currentEntity}"><g:link action="delete" id="${event.id}"
                                                                                                        onclick="if(!confirm('${message(code:'delete.warn')}')) return false"><img
                      src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/></g:link></erp:isSystemAdmin>
                </td>
              </tr>
            </g:each>
            </tbody>
          </table>

          <div class="paginateButtons">
            <g:paginate total="${totalEvents}"/>
          </div>
        </g:if>

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
      <div class="second">

        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <div class="buttons">
            <g:form controller="news" action="create">
              <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'news')])}"/></div>
              <div class="spacer"></div>
            </g:form>
          </div>
        </erp:accessCheck>

        <div id="news-container">
          <g:render template="/news/newsitems" model="[news: news, newsCount: newsCount, currentEntity: currentEntity]"/>
        </div>

        <div class="paginateButtons">
          <g:paginate total="${newsCount}"/>
        </div>

      </div>
    </div>
  </div>

</div>

</body>