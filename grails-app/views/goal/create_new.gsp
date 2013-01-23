<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="administration">
		<g:set var="entityName" value="${message(code: 'goal.label', default: 'Goal')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

        <div style="border: 1px solid #ccc; background: #ddd; margin: 0 0 10px 0;" class="cleared">
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Ziel Definition</span>
                <div style="margin: 5px 0;">Beitrag zum Weltfrieden</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Indikator</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Quellen</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
        </div>

        <div style="border: 1px solid #ccc; background: #ddd; margin: 0 0 10px 0;" class="cleared">
                <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                    <span class="gray">Ziel</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    <g:link action="none">Bearbeiten..</g:link>
                </div>
                <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                    <span class="gray">Indikator Ziel</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    <g:link action="none">Bearbeiten..</g:link>
                </div>
                <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                    <span class="gray">Quelle Ziel</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    <g:link action="none">Bearbeiten..</g:link>
                </div>
                <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                    <span class="gray">Annahme Ziel</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    <g:link action="none">Bearbeiten..</g:link>
                </div>
        </div>

        <div style="border: 1px solid #ccc; background: #ddd; margin: 0 0 10px 0;" class="cleared">
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Resultate</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Indikator Resultate</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Quelle Resultate</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Annahme Resultate</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <g:link class="buttonGreen" style="margin-top: 10px" action="edit">Resultat hinzufügen</g:link>
        </div>

        <div style="border: 1px solid #ccc; background: #ddd; margin: 0 0 10px 0;" class="cleared">
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Aktion</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Ressourcen</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Kosten</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <div style="background: #fff; border: 1px solid #ccc; padding: 10px; margin: 10px; height: 140px; width: 230px; float: left;">
                <span class="gray">Voraussetzung</span>
                <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                <g:link action="none">Bearbeiten..</g:link>
            </div>
            <g:link class="buttonGreen" style="margin-top: 10px" action="edit">Aktion hinzufügen</g:link>
        </div>

	</body>
</html>
