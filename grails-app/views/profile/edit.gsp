      <div class="body">
            <h1>Profil bearbeiten</h1>
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="update" method="post" id="${entityInstance.id}">
                    <h1>Notwendige Angaben</h1>
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullName">
                                      <g:message code="msg.fullName.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="50" id="fullName" name="fullName" value="${fieldValue(bean:entityInstance,field:'profile.fullName')}"/>
                                </td>
                            </tr>


                        </tbody>
                    </table>

                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="update" value="Ändern" /></span>
                        <span class="nav-button"><g:link controller="profile" action="show" params="[name:currentEntity.name]">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>