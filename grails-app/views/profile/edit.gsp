      <div class="body">
            <h1>Profil bearbeiten</h1>
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="update" method="post" id="${entityInstance.id}">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="title">
                                      <g:message code="entityInstance.title.label" default="Titel" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="title" name="title" value="${fieldValue(bean:entityInstance,field:'profile.title')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="fullName">
                                      <g:message code="entityInstance.fullName.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="fullName" name="fullName" value="${fieldValue(bean:entityInstance,field:'profile.fullName')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="birthDate">
                                      <g:message code="entityInstance.birthDate.label" default="Geburtstag" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:datePicker id="birthDate" name="birthDate" value="${entityInstance.profile.birthDate}" precision="day" years="${1900..Calendar.getInstance().get(Calendar.YEAR)-18}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="PLZ">
                                      <g:message code="entityInstance.PLZ.label" default="PLZ" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="PLZ" name="PLZ" value="${entityInstance.profile.PLZ}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="city">
                                      <g:message code="entityInstance.city.label" default="Stadt" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="city" name="city" value="${fieldValue(bean:entityInstance,field:'profile.city')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="street">
                                      <g:message code="entityInstance.street.label" default="Straße" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="street" name="street" value="${fieldValue(bean:entityInstance,field:'profile.street')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="tel">
                                      <g:message code="entityInstance.tel.label" default="Telefon" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="40" id="tel" name="tel" value="${fieldValue(bean:entityInstance,field:'profile.tel')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="gender">
                                      <g:message code="entityInstance.gender.label" default="Geschlecht" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select id="gender" name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${entityInstance.profile.gender}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="middle" class="name">
                                    <label for="biography">
                                      <g:message code="entityInstance.biography.label" default="Lebenslauf" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                  <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                  <fckeditor:editor name="biography" id="biography" width="550px" height="400" toolbar="Post" fileBrowser="default">
                                    ${entityInstance.profile.biography}
                                  </fckeditor:editor>
                                </td>
                            </tr>

                            <tr>
                              <td class="topic">Passwort:</td>
                              <td><g:link action="changePassword" params="[name:entityInstance.name]">Passwort ändern</g:link></td>
                            </tr>

                        </tbody>
                    </table>

                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="update" value="Ändern" /></span>
                        <span class="nav-button"><g:link controller="profile" action="showProfile" params="[name:entityInstance.name]">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>