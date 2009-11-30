<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
          <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
                <table class="form show-msg">
                    <tbody>

                        <tr class="prop">                            
                            <td valign="top" class="value msg-title">${fieldValue(bean:msgInstance, field:'subject')}</td>
                        </tr>
                        
                        <tr class="prop">
                          
                            <td valign="top" class="value msg-name">An <g:link controller="post" action="profile" params="[name:msgInstance.receiver.name]">${msgInstance.receiver.profile.fullName}</g:link> am <g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></td>
                            
                        </tr>
                    
                        <tr class="prop">                            
                            <td valign="top" class="value msg-content">${fieldValue(bean:msgInstance, field:'content')}</td>
                            
                        </tr>
                                     
                    </tbody>
                </table>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${msgInstance?.id}" />
                    <span class="button"><g:link controller="msg" action="create" params="[name:msgInstance.sender?.name]">Antworten</g:link></span>
                    <g:actionSubmit class="del" onclick="return confirm('Nachricht wirklich löschen?');" value="Löschen" params="[name:entity.name]"/>
                    <span class="nav-button"><g:link action="inbox" params="[name:entity.name]">zurück</g:link></span>
                </g:form>
            </div>
        </div>
</body>