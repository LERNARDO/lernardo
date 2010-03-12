<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Aktivitätsvorlage anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Aktivitätsvorlage anlegen</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">

      <g:hasErrors bean="${template}">
        <div class="errors">
          <g:renderErrors bean="${template}" as="list" />
        </div>
      </g:hasErrors>

      <g:form action="save" method="post">
        <table id="msg-composer">
          <tbody>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="fullName">
                      <g:message code="msg.name.label" default="Name" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.fullName','errors')}">
                    <input type="text" size="50" id="fullName" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="attribution">
                      <g:message code="msg.attribution.label" default="Primäre Zuordnung" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.attribution','errors')}">
                    <g:select id="attribution" name="attribution" from="${['Psychomotorik','Im Wald','Lernen lernen','Bewegung - Ernährung','Soziale Kompetenz - Emotionale Intelligenz','Persönliche Kompetenz - Eigenverantwortung','Handwerk & Kunst']}" value="${fieldValue(bean:template,field:'profile.attribution')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="description">
                      <g:message code="msg.description.label" default="Beschreibung" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.description','errors')}">
                    <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js').toString()}"/>
                    <fckeditor:editor name="description" id="description" width="460" height="400" toolbar="Post" fileBrowser="default">
                      ${template?.profile?.description}
                    </fckeditor:editor>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="materials">
                      <g:message code="msg.materials.label" default="Ressourcen" />:
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:select multiple="true" optionKey="id" optionValue="profile" from="${resources}" name="materials"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="duration">
                      <g:message code="msg.duration.label" default="Dauer" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.duration','errors')}">
                    <input type="text" size="10" id="duration" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> (in Minuten)
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="socialForm">
                      <g:message code="msg.socialForm.label" default="Sozialform" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.socialForm','errors')}">
                    <g:select id="socialForm" name="socialForm" from="${['offen','Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)','Großgruppe (bis 25 Kinder)']}" value="${fieldValue(bean:template,field:'profile.socialForm')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="requiredEducators">
                      <g:message code="msg.requiredEducators.label" default="Anzahl BetreuerInnen" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.requiredEducators','errors')}">
                    <g:select id="requiredEducators" name="requiredEducators" from="${1..5}" value="${template?.profile?.requiredEducators}"/> (Vorschlag)
                </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                  <label for="qualifications">
                    <g:message code="msg.qualifications.label" default="Qualifikationen" />:
                  </label>
              </td>
              <td valign="top" class="value ${hasErrors(bean:template,field:'profile.qualifications','errors')}">
                  <g:select id="qualifications" name="qualifications" from="${['keine']}" value="${template?.profile?.qualifications}"/>
              </td>
            </tr>
          </tbody>
        </table>

        <p class="bold">Gewichtungen</p>

        <table>
          <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="ll">
                      <g:message code="msg.ll.label" default="Lernen lernen" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.ll','errors')}">
                    <g:select id="ll" name="ll" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.ll}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="be">
                      <g:message code="msg.be.label" default="Bewegung & Ernährung" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.be','errors')}">
                    <g:select id="be" name="be" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.be}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="pk">
                      <g:message code="msg.pk.label" default="Persönliche Kompetenz" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.pk','errors')}">
                    <g:select id="pk" name="pk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.pk}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="si">
                      <g:message code="msg.si.label" default="Soziale & emotionale Intelligenz" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.si','errors')}">
                    <g:select id="si" name="si" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.si}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="hk">
                      <g:message code="msg.hk.label" default="Handwerk & Kunst" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.hk','errors')}">
                    <g:select id="hk" name="hk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.hk}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tlt">
                      <g:message code="msg.tlt.label" default="Teilleistungstraining" />:
                    </label>
                </td>
                <td valign="top" class="value ${hasErrors(bean:template,field:'profile.tlt','errors')}">
                    <g:select id="tlt" name="tlt" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template?.profile?.tlt}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

          </tbody>
        </table>

        <div class="buttons">
          <g:submitButton name="submitButton" value="Anlegen" />
          <g:link class="buttonGray" controller="template" action="list">Abbrechen</g:link>
          <div class="spacer"></div>
        </div>

      </g:form>
    </div>
  </div>
</body>
