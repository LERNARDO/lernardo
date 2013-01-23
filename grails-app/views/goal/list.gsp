
<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="administration">
		<title>Logframes</title>
	</head>
	<body>
    <div class="boxHeader">
        <h1>Logframes</h1>
    </div>

    <div class="buttons cleared">
        <g:form>
            <div class="button"><g:actionSubmit class="buttonGreen" action="create_new" value="Oberziel anlegen"/></div>
        </g:form>
    </div>
    
    <div id="lf_search">
        <div class="buttons cleared" style="margin-bottom: 0;">
            <g:textField name="search" size="40"/> <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="Suchen" /></div>
            <g:link action="none">erweiterte Suche</g:link>
        </div>
    </div>

    <g:each in="${1..2}">
        <div class="lf_maingoal">
            <div class="item main">
                <div>Weltfrieden <img src="${resource(dir: 'images/icons', file: 'icon_add_old.png')}" alt="mail" style="top: 1px; position: relative"/> <img src="${resource(dir: 'images/icons', file: 'icon_edit2.png')}" alt="mail" style="top: 1px; position: relative"/></div>
                <div class="description">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</div>
            </div>
            <g:each in="${1..2}">
                <div class="item sub">
                    <div >Weltfrieden <img src="${resource(dir: 'images/icons', file: 'icon_remove_old.png')}" alt="mail" style="top: 1px; position: relative"/> <img src="${resource(dir: 'images/icons', file: 'icon_edit2.png')}" alt="mail" style="top: 1px; position: relative"/></div>
                    <div class="description">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</div>
                </div>
            </g:each>
            <div class="links">
                <div style="float: left; margin-left: 70px;">
                    <g:link action="none">mehr anzeigen (3)</g:link> <g:link action="none">alle einklappen/ausklappen</g:link>
                </div>
                <img src="${resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="mail" style="top: 1px; position: relative"/>
                <img src="${resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="mail" style="top: 1px; position: relative"/>
            </div>

        </div>
    </g:each>

	</body>

</html>
