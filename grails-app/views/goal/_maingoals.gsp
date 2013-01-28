<table>
    <tr>
        <td style="width: 800px">
            <div style="border-bottom: 1px solid #ccc; border-right: 1px solid #ccc; width: 70px; padding: 3px; background: #acf;">Oberziel</div>
            <g:each in="${goalInstanceList}" var="maingoal" status="i">
                <div class="lf_maingoal">

                    <div id="maingoal${i}" class="item main">
                        <g:render template="showmaingoal" model="[maingoal: maingoal, i: i]"/>
                    </div>
                    <div style="border-bottom: 1px solid #ccc; border-right: 1px solid #ccc; width: 70px; padding: 3px; background: #acf; margin-left: 70px;">Unterziele</div>

                    <h5 style="margin-left: 70px;">Unterziel hinzufügen <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#add_subgoal${i}');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

                    <div class="zusatz-add" id="add_subgoal${i}" style="display:none; margin-left: 70px;">
                        <g:formRemote name="formRemote" url="[controller: 'goal', action: 'addSubGoal', id: maingoal.id, params: [i: i]]" update="subgoals${i}" before="showspinner('#subgoals');" after="toggle('#add_subgoal${i}');">
                            <g:textField name="name" size="30" placeholder="Name"/><br/>
                            <g:textArea name="description" rows="10" cols="100" placeholder="Beschreibung (optional)"/><br/>
                            <g:submitButton name="button" value="${message(code: 'add')}"/>
                        </g:formRemote>
                    </div>

                    <div id="subgoals${i}">
                        <g:render template="subgoals" model="[maingoal: maingoal, i: i]"/>
                    </div>

                    <div class="links">
                        <div style="float: left; margin-left: 70px;">
                            <g:link action="none">mehr anzeigen (3)</g:link> <g:link action="none">alle einklappen/ausklappen</g:link>
                        </div>
                        <img src="${resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="mail" style="top: 1px; position: relative"/>
                        <img src="${resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="mail" style="top: 1px; position: relative"/>
                    </div>

                </div>
            </g:each>
        </td>
        <td style="width: 250px; vertical-align: top; padding-left: 15px;">
            <div id="lf_search">
                <div class="buttons cleared" style="margin-bottom: 0;">
                    <g:textField name="search" size="40"/> <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="Suchen" /></div>
                    <g:link action="none">erweiterte Suche</g:link>
                </div>
            </div>
        </td>
    </tr>
</table>