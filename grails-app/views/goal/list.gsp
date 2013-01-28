
<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="administration">
		<title>Logframes</title>

        <g:javascript>
            $(function() {
                ${remoteFunction(controller: "goal", action: "showMainGoals", update: "maingoals", before: "showspinner('#maingoals')")}
            });
        </g:javascript>

	</head>
	<body>
    <div class="boxHeader">
        <h1>Logframes</h1>
    </div>

    %{--<div class="buttons cleared">
        <g:form>
            <div class="button"><g:actionSubmit class="buttonGreen" action="create_new" value="Oberziel anlegen"/></div>
        </g:form>
    </div>--}%

    <div class="zusatz">
        <h5>Oberziel hinzufügen <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#add_maingoal');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

        <div class="zusatz-add" id="add_maingoal" style="display:none; width: 630px;">
            <g:formRemote name="formRemote" url="[controller: 'goal', action: 'addMainGoal']" update="maingoals" before="showspinner('#maingoals');" after="toggle('#add_maingoal');">
                <g:textField name="name" size="30" placeholder="Name"/><br/>
                <g:textArea name="description" rows="10" cols="100" placeholder="Beschreibung (optional)"/><br/>
                <g:submitButton name="button" value="${message(code: 'add')}"/>
            </g:formRemote>
        </div>

    </div>

    <div id="maingoals" style="margin-top: 15px;"></div>

	</body>

</html>
