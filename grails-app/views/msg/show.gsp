        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
                <table class="form show-msg">
                    <tbody>

                    
                        %{--<tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="msg.id.label" default="Id" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:msgInstance, field:'id')}</td>
                            
                        </tr>--}%
                    
                        <tr class="prop">                            
                            <td valign="top" class="value msg-title">${fieldValue(bean:msgInstance, field:'subject')}</td>
                        </tr>
                        
                        <tr class="prop">
                          
                            <td valign="top" class="value">An <g:link controller="post" action="profile" params="[name:msgInstance.receiver.name]">${msgInstance.receiver.profile.fullName}</g:link> am <g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></td>
                            
                        </tr>
                    
                        <tr class="prop">                            
                            <td valign="top" class="value msg-content">${fieldValue(bean:msgInstance, field:'content')}</td>
                            
                        </tr>
                    
                        %{--<tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="msg.lastUpdated.label" default="Last Updated" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:msgInstance, field:'lastUpdated')}</td>
                            
                        </tr>--}%
                    
                        %{--<tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="msg.read.label" default="Read" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:msgInstance, field:'read')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="msg.entity.label" default="Entity" />:
                            </td>
                            
                            <td valign="top" class="value"><g:link controller="entity" action="show" id="${msgInstance?.entity?.id}">${msgInstance?.entity?.encodeAsHTML()}</g:link></td>
                            
                        </tr>--}%
                    
                    </tbody>
                </table>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${msgInstance?.id}" />
                    <span class="button"><g:link controller="msg" action="create" params="[name:msgInstance.sender?.name]">Antworten</g:link></span>
                    <g:actionSubmit class="delete" onclick="return confirm('Nachricht wirklich löschen?');" value="Löschen" />
                    <span class="nav-button"><g:link action="inbox">zurück</g:link></span>
                </g:form>
            </div>
        </div>