<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Beurteilung bearbeiten</title>
  <g:javascript library="jquery"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Beurteilung bearbeiten</h1>
  </div>
<div class="boxGray">

            <g:hasErrors bean="${evaluationInstance}">
            <div class="errors">
                <g:renderErrors bean="${evaluationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" params="[name:entity.name]">
                <input type="hidden" name="id" value="${evaluationInstance?.id}" />
                <input type="hidden" name="version" value="${evaluationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description">
                                    <g:message code="evaluation.description.label" default="Beschreibung" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:evaluationInstance,field:'description','errors')}">
                                  <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                  <fckeditor:editor name="description" id="description" width="550" height="200" toolbar="Post" fileBrowser="default">
                                    ${evaluationInstance.description}
                                  </fckeditor:editor></td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="method">
                                    <g:message code="evaluation.method.label" default="Maßnahme" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:evaluationInstance,field:'method','errors')}">
                                  <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                  <fckeditor:editor name="method" id="method" width="550" height="200" toolbar="Post" fileBrowser="default">
                                    ${evaluationInstance.method}
                                  </fckeditor:editor>
                            </tr> 

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:submitButton name="submitButton" value="Aktualisieren" />
                    <g:link class="buttonBlue" action="del" id="${evaluationInstance.id}" params="[name:entity.name]" onclick="return confirm('Bist du sicher?');" >Löschen</g:link>
                    <g:link class="buttonGray" action="list" params="[name:entity.name]">Abbrechen</g:link>
                    <div class="spacer"></div>
                </div>
            </g:form>
        </div>
    </body>
