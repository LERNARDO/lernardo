<head>
  <meta name="layout" content="private"/>
  <title><g:message code="educator"/> - ${educator.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="educator"/> - ${educator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">

      <table>
        
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="educator.profile.gender"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.title"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.firstName"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.lastName"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.birthDate"/>
          </td>
        </tr>

        <tr>
          <td width="90" height="25" valign="middle" class="value-show">
            <app:showGender gender="${educator.profile.gender}"/>
          </td>
          <td width="120" valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.title') ?: '<div class="italic">Leer</div>'}
          </td>
          <td width="180" valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.firstName') ?: '<div class="italic">Leer</div>'}
          </td>
          <td width="210" valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.lastName') ?: '<div class="italic">Leer</div>'}
          </td>
          <td valign="middle" class="value-show">
            <g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/>
          </td>
        </tr>
      </table>

      <table>

        <tr>
          <td class="name-show">
            <g:message code="educator.profile.education"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.employment"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.enlisted"/>
          </td>
        </tr>

        <tr>
          <td width="280" height="25" valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.education') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td width="280" valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.employment') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td valign="middle" class="value-show">
            ${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: '<div class="italic">'+message(code:'no')+'</div>'}
          </td>
        </tr>

        <tr>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.interests"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.inChargeOf"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="educator.profile.languages"/>
          </td>
        </tr>

        <tr>
          <td height="60" valign="top" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.interests') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
          </td>
          <td valign="top" class="value-show">
            <ul>
              <g:each in="${educator.profile.inChargeOf}" var="inchargeof">
                <li><app:getInChargeOf inchargeof="${inchargeof}"/></li>
              </g:each>
            </ul>
          </td>
          <td valign="top" class="value-show">
            <ul>
              <g:each in="${educator.profile.languages}" var="language">
                <li><app:getLanguages language="${language}"/></li>
              </g:each>
            </ul>
          </td>
        </tr>
       <tr>
        <td colspan="3" valign="top" class="name-show">
        <g:message code="educator.profile.colonia"/>:
        </td>
          </tr>
        <tr>
        <td  valign="top" class="value-show">
        <g:if test="${colony}"><g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.fullName}</g:link></g:if><g:else><span class="italic"><g:message code="educator.profile.colonia.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span></g:else>
        </td>
        <td colspan="3" valign="top" >
        </td>
        </tr>
      </table>

      <h4><g:message code="educator.profile.curAddress"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.currentStreet"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.currentZip"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.currentCity"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.currentCountry"/>
            </td>
          </tr>

          <tr>
            <td width="280" height="25" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="105" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentCity') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="110" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
          </tr>

        </table>
      </div>

      <h4><g:message code="educator.profile.origin"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.originStreet"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.originZip"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.originCity"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.originCountry"/>
            </td>
          </tr>

          <tr>
            <td width="280" height="25" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="105" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originCity') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="110" valign="middle" class="value-show">
              <app:getNationalities nationality="${educator.profile.originCountry}"/>
            </td>

          </tr>

        </table>
      </div>

      <h4><g:message code="educator.profile.emContact"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactStreet"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactZip"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactCity"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactCountry"/>
            </td>
          </tr>

          <tr>
            <td width="280" height="25" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="105" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="110" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
          </tr>

        </table>

        <table>

          <tr>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactPhone"/>
            </td>
            <td valign="top" class="name-show">
              <g:message code="educator.profile.contactMail"/>
            </td>
          </tr>

          <tr>
            <td width="280" height="25" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="340" valign="middle" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
          </tr>

        </table>
      </div>

      <div class="email">
        <table>

          <tr>
            <app:isAdmin>
              <td width="100" valign="middle">
                <g:message code="active"/>:
                <g:formatBoolean boolean="${educator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </app:isAdmin>

            <td width="280" valign="middle">
              <g:message code="educator.profile.email"/>:
              ${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td valign="middle">
              <g:message code="languageSelection"/>:
              <app:showLocale locale="${parent?.user?.locale}"/>
            </td>
          </tr>

        </table>
      </div>
    </div>

    <app:isMeOrAdmin entity="${educator}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${educator?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz">
      <h5><g:message code="educator.profile.inOut"/> <app:isMeOrAdmin entity="${educator}"><a href="#" id="show-dates"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Datum hinzufügen"/></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-dates" targetId="dates"/>
      </jq:jquery>
      <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="hideform('#dates')">
          <g:datePicker name="date" value="" precision="day"/>
          <g:hiddenField name="type" value="${educator.profile.dates.size() % 2 == 0 ? 'join' : 'end'}"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="${educator}"/>
      </div>
    </div>

  </div>
</div>
</body>
