  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Aktivitätsvorlage bearbeiten</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Aktivitätsvorlage bearbeiten</h1>
    </div>
  <div class="boxGray">
        <div class="body">
            <g:hasErrors bean="${template}">
              <div class="errors">
                <g:renderErrors bean="${template}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="update" method="post" id="${template.id}">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">
                                      <g:message code="template.name.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="name" name="name" value="${fieldValue(bean:template,field:'profile.fullName')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attribution">
                                      <g:message code="template.attribution.label" default="Zuordnung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="attribution" name="attribution" from="${['Psychomotorik','Im Wald','Lernen lernen','Bewegung - Ernährung','Soziale Kompetenz - Emotionale Intelligenz','Persönliche Kompetenz - Eigenverantwortung','Handwerk & Kunst']}" value="${template.profile.attribution}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">
                                      <g:message code="template.description.label" default="Beschreibung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                  <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                  <fckeditor:editor name="description" id="description" width="100%" height="400" toolbar="Post" fileBrowser="default">
                                    ${template.profile.description}
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
                                      <g:message code="template.duration.label" default="Dauer" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="duration" name="duration" value="${template.profile.duration}"/> (in Minuten)
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="socialForm">
                                      <g:message code="template.socialForm.label" default="Sozialform" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="socialForm" name="socialForm" from="${['offen','Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)','Großgruppe (bis 25 Kinder)']}" value="${template.profile.socialForm}"/>
                                </td>
                            </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="requiredEducators">
                                  <g:message code="template.requiredEducators.label" default="Teamgröße" />:
                                </label>
                            </td>
                            <td valign="top" class="value">
                                <g:select id="requiredEducators" name="requiredEducators" from="${1..5}" value="${template.profile.requiredEducators}"/> (Anzahl der Pädagogen)
                            </td>
                        </tr>

                            %{--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="qualifications">
                                      <g:message code="template.qualifications.label" default="Qualifikationen" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="qualifications" name="qualifications" from="${['keine']}" value="${template.qualifications}"/>
                                </td>
                            </tr>--}%

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ll">
                                      <g:message code="template.ll.label" default="Lernen lernen" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="ll" name="ll" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.ll}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="be">
                                      <g:message code="template.be.label" default="Bewegung & Ernährung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="be" name="be" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.be}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pk">
                                      <g:message code="template.pk.label" default="Persönliche Kompetenz" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="pk" name="pk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.pk}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="si">
                                      <g:message code="template.si.label" default="Soziale & emotionale Intelligenz" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="si" name="si" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.si}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hk">
                                      <g:message code="template.hk.label" default="Handwerk & Kunst" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="hk" name="hk" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.hk}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tlt">
                                      <g:message code="template.tlt.label" default="Teilleistungstraining" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="tlt" name="tlt" from="${[0:'kein',1:'niedrig',2:'mittel',3:'hoch']}" value="${template.profile.tlt}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <div class="buttons">
                        <g:submitButton name="submitButton" value="Ändern" />
                        <g:link class="buttonGray" action="show" id="${template.id}" params="[name:currentEntity.name]">Abbrechen</g:link>
                        <div class="spacer"></div>
                    </div>
            </g:form>
        </div>
    </div>
  </body>