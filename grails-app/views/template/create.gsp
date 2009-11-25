  <head>
    <meta name="layout" content="private" />
    <title>Aktivitätsvorlage anlegen</title>
  </head>
  <body>
      <div class="body">
            <h1>Aktivitätsvorlage anlegen</h1>
            <g:hasErrors bean="${templateInstance}">
              <div class="errors">
                <g:renderErrors bean="${templateInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="save" method="post" id="${templateInstance.id}">
                    <h1>Notwendige Angaben</h1>
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">
                                      <g:message code="msg.name.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'name','errors')}">
                                    <input type="text" size="50" id="name" name="name" value="${fieldValue(bean:templateInstance,field:'name')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attribution">
                                      <g:message code="msg.attribution.label" default="Zuordnung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'name','errors')}">
                                    <input type="text" size="50" id="attribution" name="attribution" value="${fieldValue(bean:templateInstance,field:'attribution')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">
                                      <g:message code="msg.description.label" default="Beschreibung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'description','errors')}">
                                    <textarea rows="10" cols="70" id="description" name="description">${fieldValue(bean:templateInstance, field:'description')}</textarea>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="duration">
                                      <g:message code="msg.duration.label" default="Dauer" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'duration','errors')}">
                                    <input type="text" size="50" id="duration" name="duration" value="${fieldValue(bean:templateInstance,field:'duration')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="socialForm">
                                      <g:message code="msg.socialForm.label" default="Sozialform" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'socialForm','errors')}">
                                    <g:select id="socialForm" name="socialForm" from="${['Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)']}" value="${templateInstance.ll}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="materials">
                                      <g:message code="msg.materials.label" default="Materialien" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'materials','errors')}">
                                    <input type="text" size="50" id="materials" name="materials" value="${fieldValue(bean:templateInstance,field:'materials')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ll">
                                      <g:message code="msg.ll.label" default="Lernen lernen" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'ll','errors')}">
                                    <g:select id="ll" name="ll" from="${0..3}" value="${templateInstance.ll}"/>
                                </td>
                            </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="be">
                                  <g:message code="msg.be.label" default="Bewegung & Ernährung" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'be','errors')}">
                                <g:select id="be" name="be" from="${0..3}" value="${templateInstance.be}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="pk">
                                  <g:message code="msg.pk.label" default="Persönliche Kompetenz" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'pk','errors')}">
                                <g:select id="pk" name="pk" from="${0..3}" value="${templateInstance.pk}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="si">
                                  <g:message code="msg.si.label" default="Soziale & emotionale Intelligenz" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'si','errors')}">
                                <g:select id="si" name="si" from="${0..3}" value="${templateInstance.si}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="hk">
                                  <g:message code="msg.hk.label" default="Handwerk & Kunst" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'hk','errors')}">
                                <g:select id="hk" name="hk" from="${0..3}" value="${templateInstance.hk}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="tlt">
                                  <g:message code="msg.tlt.label" default="Teilleistungstraining" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'tlt','errors')}">
                                <g:select id="tlt" name="tlt" from="${0..3}" value="${templateInstance.tlt}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="qualifications">
                                  <g:message code="msg.qualifications.label" default="Qualifikationen" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'qualifications','errors')}">
                                <g:select id="qualifications" name="qualifications" from="${['keine']}" value="${templateInstance.qualifications}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="requiredPaeds">
                                  <g:message code="msg.requiredPaeds.label" default="Teamgröße" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:templateInstance,field:'requiredPaeds','errors')}">
                                <g:select id="requiredPaeds" name="requiredPaeds" from="${1..5}" value="${templateInstance.requiredPaeds}"/>
                            </td>
                        </tr>

                        </tbody>
                    </table>

                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="save" value="Anlegen" /></span>
                        <span class="nav-button"><g:link controller="template" action="list">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>
    </body>
