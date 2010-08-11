<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
            <tr class="prop">
                <td valign="top" class="name-show">
                   <g:message code="groupClient.profile.name" />:
                </td>
              <td valign="top" class="name-show">
                 <g:message code="groupClient.profile.description" />:
              </td>
            </tr>
            <tr class="prop">
              <td width="200" valign="top" class="value-show">${fieldValue(bean:group, field:'profile.fullName').decodeHTML()}</td>
              <td width="500" valign="top" class="value-show">${fieldValue(bean:group, field:'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
            </tr>
      </table>
    </div>

    <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:hasRoleOrType>

    <div class="zusatz">
      <h5>Betreute <app:isOperator entity="${currentEntity}"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:isOperator></h5>
      <div class="zusatz-add" id="clients" style="display:none">
      Die Betreuten können nach folgenden Merkmalen eingegrenzt werden: (max. 30 Treffer werden angezeigt!)<br/>
        <g:formRemote name="formRemote0" url="[controller:'groupClientProfile', action:'updateselect']" update="clientselect">

          <table>
            <tr>
              <td>Name:</td>
              <td><g:textField name="name" /></td>
            </tr>
            <tr>
              <td>Geburtsdatum:</td>
              <td>zwischen <g:datePicker name="birthDate1" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1900}" noSelection="['all':'Alle']"/> und <g:datePicker name="birthDate2" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1901}" noSelection="['all':'Alle']"/></td>
            </tr>
            <tr>
              <td>Geschlecht:</td>
              <td><g:select name="gender" from="${['0':'Beide','1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/></td>
            </tr>
            <tr>
              <td>Größe:</td>
              <td>von <g:select from="${100..250}" name="size1" noSelection="['all':'Alle']"/> bis <g:select from="${100..250}" name="size2" noSelection="['all':'Alle']"/> (cm)</td>
            </tr>
            <tr>
              <td>Gewicht:</td>
              <td>von <g:select from="${10..150}" name="weight1" noSelection="['all':'Alle']"/> bis <g:select from="${10..150}" name="weight2" noSelection="['all':'Alle']"/> (kg)</td>
            </tr>
            <tr>
              <td>Stadt:</td>
              <td><g:textField name="city" /></td>
            </tr>
            <tr>
              <td>Schulstufe:</td>
              <td>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select name="schoolLevel" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value" noSelection="['all':'Alle']"/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select name="schoolLevel" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value" noSelection="['all':'Alle']"/>
                </g:if>
              </td>
            </tr>
            <tr>
              <td>Berufstätig:</td>
              <td><g:select name="job" from="${['0':'Beide','1':'Ja','2':'Nein']}" optionKey="key" optionValue="value"/></td>
            </tr>
          </table>
          <g:submitButton name="button" value="Eingrenzen"/>
          <div class="spacer"></div>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller:'groupClientProfile', action:'addClient', id:group.id]" update="clients2" before="showspinner('#clients2')">
          <div id="clientselect">
            <g:render template="searchresults" model="[allClients: allClients]"/>
          </div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, group: group, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>