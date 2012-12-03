
<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="administration">
		<title>Marco Logico</title>
	</head>
	<body>
    <div class="boxHeader">
        <h1>Marco Logico</h1>
    </div>

    %{--<div class="buttons cleared">
        <g:form>
            <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="Oberziel anlegen"/></div>
        </g:form>
    </div>--}%

    <div id="marcoContainer">

        <table style="border-collapse: collapse; font-size: 11px;">
            <tr>
                <td style="background: #ff0; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Oberziele
                </td>
                <td style="background: #ff0; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Indikatoren
                </td>
                <td style="background: #ff0; padding: 10px; border: 1px solid #000; text-align: center; width: 150px;">
                    zu erwartendes Ergebnis
                </td>
                <td style="background: #ffc; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Unterziele
                </td>
                <td style="background: #ffc; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Indikatoren
                </td>
                <td style="background: #ffc; padding: 10px; border: 1px solid #000; text-align: center; width: 150px;">
                    zu erwartendes Ergebnis
                </td>
                <td style="background: #fcc; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Aktionen
                </td>
                <td style="background: #fcc; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Verantwortlicher Pädagoge
                </td>
                <td style="background: #fcc; padding: 10px; border: 1px solid #000; text-align: center; width: 100px;">
                    Materialien, Ressourcen
                </td>
                <td style="background: #fcc; padding: 10px; border: 1px solid #000; text-align: center; width: 50px;">
                    Datum
                </td>
            </tr>
        </table>

        <p>Aufbau wenn jedes Ziel mehrere Indikatoren hat:</p>

        <table style="border-collapse: collapse; font-size: 11px;">
            <g:each in="${1..2}" var="mainGoal" status="i">
                <tr style="background: #fcc; border: 1px solid #000;">

                    <td style="width: 100px; padding: 10px; border: 1px solid #000;">
                        Beschreibung Oberziel<br/>
                        Beginn und Ende
                    </td>

                    <td %{--style="border: 1px solid #000;"--}%>

                        %{-- Für jeden Indikator eine eigene Tabelle --}%

                        <g:each in="${1..2}">
                        <table style="margin: 10px; border: 1px solid #000;">
                            <tr style="background: #ccf;">
                                <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                    Beschreibung Indikator
                                </td>
                                <td style="padding: 10px; width: 150px; border: 1px solid #000;">
                                    Zu erwartendes Ergebnis
                                </td>
                                <td>

                                    %{-- Für jedes Unterziel eine eigene Tabelle --}%

                                    <g:each in="${1..2}">
                                    <table style="margin: 10px; border: 1px solid #000;">
                                        <tr style="background: #cfc;">
                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                Beschreibung Unterziel
                                            </td>
                                            <td>

                                                %{-- Für jeden Indikator eines Unterziels eine eigene Tabelle --}%

                                                <g:each in="${1..2}">
                                                    <table style="margin: 10px; border: 1px solid #000;">
                                                        <tr style="background: #fcf;">
                                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                                Beschreibung Indikator
                                                            </td>
                                                            <td style="padding: 10px; width: 150px; border: 1px solid #000;">
                                                                Zu erwartendes Ergebnis
                                                            </td>
                                                            <td>

                                                            %{-- Für jedes Aktion eine eigene Tabelle --}%

                                                                <g:each in="${1..2}">
                                                                    <table style="margin: 10px; border: 1px solid #000;">
                                                                        <tr style="background: #cff;">
                                                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                                                Name Aktion
                                                                            </td>
                                                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                                                Verantwortlicher
                                                                            </td>
                                                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                                                Materialien
                                                                            </td>
                                                                            <td style="padding: 10px; width: 50px; border: 1px solid #000;">
                                                                                Datum
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </g:each>

                                                            </td>

                                                        </tr>
                                                    </table>
                                                </g:each>

                                            </td>
                                        </tr>
                                    </table>
                                    </g:each>

                                </td>
                            </tr>
                        </table>
                        </g:each>

                    </td>
                </tr>
            </g:each>
        </table>

    <p>Aufbau wenn jedes Ziel nur einen Indikator hat:</p>

    <table style="border-collapse: collapse; font-size: 11px;">
        <g:each in="${1..2}" var="mainGoal" status="i">
            <tr style="background: #fcc; border: 1px solid #000;">

                <td style="width: 100px; padding: 10px; border: 1px solid #000;">
                    Beschreibung Oberziel<br/>
                    Beginn und Ende
                </td>
                <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                    Beschreibung Indikator
                </td>
                <td style="padding: 10px; width: 150px; border: 1px solid #000;">
                    Zu erwartendes Ergebnis
                </td>
                <td>

                %{-- Für jedes Unterziel eine eigene Tabelle --}%

                <g:each in="${1..2}">
                    <table style="margin: 10px; border: 1px solid #000;">
                        <tr style="background: #cfc;">
                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                Beschreibung Unterziel
                            </td>
                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                Beschreibung Indikator
                            </td>
                            <td style="padding: 10px; width: 150px; border: 1px solid #000;">
                                Zu erwartendes Ergebnis
                            </td>
                            <td>

                            %{-- Für jedes Aktion eine eigene Tabelle --}%

                                <g:each in="${1..2}">
                                    <table style="margin: 10px; border: 1px solid #000;">
                                        <tr style="background: #cff;">
                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                Name Aktion
                                            </td>
                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                Verantwortlicher
                                            </td>
                                            <td style="padding: 10px; width: 100px; border: 1px solid #000;">
                                                Materialien
                                            </td>
                                            <td style="padding: 10px; width: 50px; border: 1px solid #000;">
                                                Datum
                                            </td>
                                        </tr>
                                    </table>
                                </g:each>

                            </td>

                        </tr>
                    </table>
                </g:each>

                </td>
            </tr>
        </g:each>
    </table>

    </div>

	</body>

</html>
