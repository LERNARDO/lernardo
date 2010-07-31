<head>
  <meta name="layout" content="private"/>
  <title><g:message code="partner"/> - ${partner.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="partner"/> - ${partner.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">

      <table>
         <tr class="prop">
            <td class="name-show">
            <g:message code="partner.profile.name"/>
            </td>
            <td colspan="2" valign="top" class="name-show">
             <g:message code="partner.profile.description"/>
            </td>
            <td valign="top" class="name-show">
            <g:message code="partner.profile.website"/>
            </td>
         </tr>
         <tr class="prop">
            <td  class="value-show">
              <g:link action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link>
            </td>
           <td  colspan="2" class="value-show">
             ${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">'+message(code:'noData')+'</div>'}
           </td>
           <td  class="value-show">
             ${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">'+message(code:'noData')+'</div>'}
           </td>
         </tr>

        <tr class="prop">
            <td class="name-show">
           <g:message code="partner.profile.phone"/>
            </td>
            <td colspan="3" valign="top" class="name-show">
             <g:message code="partner.profile.services"/>
            </td>

         </tr>
         <tr class="prop">
            <td width="200" class="value-show">
              ${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">'+message(code:'noData')+'</div>'}               </td>
           <td width="421" colspan="3" class="value-show">
            <ul>
              <g:each in="${partner.profile.services}" var="service">
                <li><app:getPartnerService service="${service}"/></li>
              </g:each>
            </ul>
           </td>
         </tr>
        <tr class="prop">
        <td colspan="4" valign="top" class="name-show">
        <g:message code="partner.profile.colonia"/>
        </td>
          </tr>
        <tr>
        <td  valign="top" class="value-show">
        <g:if test="${colony}"><g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.fullName}</g:link></g:if><g:else><span class="italic"><g:message code="partner.profile.colonia.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span></g:else> 
        </td>
        <td colspan="3" valign="top" >
        </td>
        </tr>
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="partner.profile.street"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="partner.profile.zip"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="partner.profile.city"/>
          </td>
          <td valign="top" class="name-show">
            <g:message code="partner.profile.country"/>
          </td>
        </tr>
        <tr class="prop">
          <td width="290" valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
          <td width="101" valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
          <td width="210" align="top" class="value-show"><app:getNationalities nationality="${partner.profile.country}"/></td>
        </tr>
      </table>

    <div class="email">
       <table>
          <tr class="prop">
            <app:isAdmin>
            <td width="60" valign="top">
              <span class="bold"><g:message code="active"/></span>
            </td>
            <td width="50" valign="top" ><g:formatBoolean boolean="${partner.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </app:isAdmin>
            <td width="60" valign="top" >
              <span class="bold"><g:message code="facility.profile.email"/>:</span>
            </td>
            <td valign="top" >${fieldValue(bean: partner, field: 'user.email') ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
          </tr>
        </table>
      </div> <!-- div email close -->


    </div>

    <app:isMeOrAdmin entity="${partner}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${partner?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

%{--    <div>
      <h1><g:message code="partner.profile.services"/> <app:isMeOrAdmin entity="${partner}"><a onclick="toggle('#services'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Service hinzufügen" /></a></app:isMeOrAdmin></h1>
      <div id="services" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'partnerProfile', action:'addService', id:partner.id]" update="services2" before="showspinner('#services2')">
          <g:textField name="service" size="30"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="services2">
        <g:render template="services" model="${partner}"/>
      </div>
    </div>--}%

    <div class="zusatz">
      <h5><g:message code="partner.profile.contacts"/> <app:isMeOrAdmin entity="${partner}"><a onclick="toggle('#contacts'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ansprechperson hinzufügen" /></a></app:isMeOrAdmin></h5>
      <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'partnerProfile', action:'addContact', id:partner.id]" update="contacts2" before="showspinner('#contacts2')">

          <table>
            <tr>
              <td><g:message code="partner.profile.contactFirstName"/>: </td>
              <td><g:textField name="firstName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactLastName"/>: </td>
              <td><g:textField name="lastName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactCountry"/>: </td>
              <td><g:textField name="country" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactZip"/>: </td>
              <td><g:textField name="zip" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactCity"/>: </td>
              <td><g:textField name="city" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactStreet"/>: </td>
              <td><g:textField name="street" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactPhone"/>: </td>
              <td><g:textField name="phone" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactEmail"/>: </td>
              <td><g:textField name="email" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="partner.profile.contactFunction"/>: </td>
              <td><g:textField name="function" size="30"/></td>
            </tr>
          </table>      

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="${partner}"/>
      </div>
    </div>

  </div>
</div>
</body>
