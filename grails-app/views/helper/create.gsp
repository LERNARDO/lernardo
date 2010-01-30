<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Hilfethemen</title>
  <g:javascript library="jquery"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Hilfethema erstellen</h1>
  </div>
<div class="boxGray">

            <g:hasErrors bean="${helperInstance}">
            <div class="errors">
                <g:renderErrors bean="${helperInstance}" as="list" />
            </div>
            </g:hasErrors>

            <g:form action="save" method="post" params="[name:entity.name]">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">
                                      <g:message code="helper.title.label" default="Titel" />
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:helperInstance,field:'title','errors')}">
                                    <input type="text" size="60" id="title" name="title" value="${fieldValue(bean:helperInstance,field:'title')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">
                                      <g:message code="helper.content.label" default="Inhalt" />
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:helperInstance,field:'content','errors')}">
                                  <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                  <fckeditor:editor name="content" id="content" width="600" height="300" toolbar="Post" fileBrowser="default">
                                    ${helperInstance.content}
                                  </fckeditor:editor>
                                    </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type">
                                      <g:message code="helper.type.label" default="Für" />
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:helperInstance,field:'type','errors')}">
                                    <g:select id="type" name="type" from="${[Paed:'Pädagogen',User:'Moderatoren']}" value="${fieldValue(bean:helperInstance, field:'type')}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <g:submitButton name="submitButton" value="Anlegen" />
                    <div class="spacer"></div>
                </div>
            </g:form>
        </div>
    </body>
