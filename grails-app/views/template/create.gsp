<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Aktivitätsvorlage anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Aktivitätsvorlage anlegen</h1>
  </div>
  <div class="boxGray">
      <div class="body">
            <g:hasErrors bean="${templateInstance}">
              <div class="errors">
                <g:renderErrors bean="${templateInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="save" method="post">
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">
                                      <g:message code="msg.name.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.fullName','errors')}">
                                    <input type="text" size="50" id="name" name="name" value="${fieldValue(bean:templateInstance,field:'profile.fullName')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attribution">
                                      <g:message code="msg.attribution.label" default="Primäre Zuordnung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.attribution','errors')}">
                                    <g:select id="attribution" name="attribution" from="${['Psychomotorik','Im Wald','Lernen lernen','Bewegung - Ernährung','Soziale Kompetenz - Emotionale Intelligenz','Persönliche Kompetenz - Eigenverantwortung','Handwerk & Kunst']}" value="${fieldValue(bean:templateInstance,field:'profile.attribution')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">
                                      <g:message code="msg.description.label" default="Beschreibung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.description','errors')}">
                                    <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                    <fckeditor:editor name="description" id="description" width="460" height="400" toolbar="Post" fileBrowser="default">
                                      ${templateInstance?.profile?.description}
                                    </fckeditor:editor>
                                </td>
                            </tr>

%{--                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="materials">
                                      <g:message code="msg.materials.label" default="Materialien" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'materials','errors')}">
                                    <input type="text" size="70" id="materials" name="materials" value="${fieldValue(bean:templateInstance,field:'materials')}"/>
                                </td>
                            </tr>--}%
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="duration">
                                      <g:message code="msg.duration.label" default="Dauer" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.duration','errors')}">
                                    <input type="text" size="10" id="duration" name="duration" value="${fieldValue(bean:templateInstance,field:'profile.duration')}"/> (in Minuten)
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="socialForm">
                                      <g:message code="msg.socialForm.label" default="Sozialform" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.socialForm','errors')}">
                                    <g:select id="socialForm" name="socialForm" from="${['offen','Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)','Großgruppe (bis 25 Kinder)']}" value="${fieldValue(bean:templateInstance,field:'profile.socialForm')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredPaeds">
                                      <g:message code="msg.requiredPaeds.label" default="Anzahl BetreuerInnen" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.requiredPaeds','errors')}">
                                    <g:select id="requiredPaeds" name="requiredPaeds" from="${1..5}" value="${templateInstance?.profile?.requiredPaeds}"/> (Vorschlag)
                                </td>
                            </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="qualifications">
                                  <g:message code="msg.qualifications.label" default="Qualifikationen" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.qualifications','errors')}">
                                <g:select id="qualifications" name="qualifications" from="${['keine']}" value="${templateInstance?.profile?.qualifications}"/>
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
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.ll','errors')}">
                                    <g:select id="ll" name="ll" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.ll}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="be">
                                  <g:message code="msg.be.label" default="Bewegung & Ernährung" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.be','errors')}">
                                <g:select id="be" name="be" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.be}" optionKey="key" optionValue="value"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="pk">
                                  <g:message code="msg.pk.label" default="Persönliche Kompetenz" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.pk','errors')}">
                                <g:select id="pk" name="pk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.pk}" optionKey="key" optionValue="value"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="si">
                                  <g:message code="msg.si.label" default="Soziale & emotionale Intelligenz" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.si','errors')}">
                                <g:select id="si" name="si" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.si}" optionKey="key" optionValue="value"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="hk">
                                  <g:message code="msg.hk.label" default="Handwerk & Kunst" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.hk','errors')}">
                                <g:select id="hk" name="hk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.hk}" optionKey="key" optionValue="value"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="tlt">
                                  <g:message code="msg.tlt.label" default="Teilleistungstraining" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'profile.tlt','errors')}">
                                <g:select id="tlt" name="tlt" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${templateInstance?.profile?.tlt}" optionKey="key" optionValue="value"/>
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
