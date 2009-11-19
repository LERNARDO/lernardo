<head>
  <g:javascript library="jquery"/>
</head>
          <div class="body">
            <h1>Nachricht verfassen</h1>
            <g:hasErrors bean="${msgInstance}">
              <div id="flash-msg">
              <div class="errors">
                <g:renderErrors bean="${msgInstance}" as="list" />
            </div>
              </div>
            </g:hasErrors>
            <g:form action="save" method="post" params="[name:entity.name]" id="${msgInstance.id}">
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="entity">
                                      <g:message code="msg.entity.label" default="An" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <span id="entity" class="bold">${entity.profile.fullName}</span>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subject">
                                      <g:message code="msg.subject.label" default="Betreff" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:msgInstance,field:'subject','errors')}">
                                    <input type="text" size="70" id="subject" name="subject" value="${fieldValue(bean:msgInstance,field:'subject')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">
                                      <g:message code="msg.content.label" default="Nachricht" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:msgInstance,field:'content','errors')}">
                                    <textarea rows="10" cols="70" id="content" name="content" >${fieldValue(bean:msgInstance, field:'content')}</textarea>
                                </td>
                            </tr> 
                            <tr>
                              <td>&nbsp;</td>
                              <td>
                                <div class="buttons">             
                                    <span class="button"><g:actionSubmit class="save" action="save" value="Senden" /></span>
                                    <span class="nav-button"><g:link controller="profile" action="show" params="[name:entity.name]">Abbrechen</g:link></span>
                                </div>
                              </td>
                            </tr>                  
                        </tbody>
                    </table>
            </g:form>
        </div>