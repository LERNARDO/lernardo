<head>
  <title>Lernardo | Nachricht</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerBlue">
  <h1>Mein Postfach: Nachricht</h1>
</div>
<div class="boxGray">
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
                            <td valign="top" class="value msg-content">${fieldValue(bean:msgInstance, field:'content').decodeHTML()}</td>
                            
                        </tr>
                                     
                    </tbody>
                </table>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${msgInstance?.id}" />
                    %{--reply is only possible when sender account is enabled--}%
                    <app:isEnabled entityName="${msgInstance.sender.name}">
                      <g:link class="buttonBlue" controller="msg" action="create" params="[name:msgInstance.sender?.name]">Antworten</g:link>
                    </app:isEnabled>
                    <g:link class="buttonBlue" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[name:entity.name,box:box]">Löschen</g:link>
                    <g:link class="buttonGray" action="inbox" params="[name:entity.name]">zurück</g:link>
                    <div class="spacer"></div>
                </g:form>
            </div>
        </div>
  </div>
</body>