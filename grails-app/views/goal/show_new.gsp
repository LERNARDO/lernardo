<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="administration">
		<g:set var="entityName" value="${message(code: 'goal.label', default: 'Goal')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>

        <script type="text/javascript">

                setModal = function(id, name, text, title, type) {
                    $('#hiddenId').val(id);
                    $('#hiddenType').val(type);
                    $('#modaltext').attr('name', name);
                    $('#modaltext').val(text);
                    $('#modaltitle').html(title);

                    $('#modalbox').modal();
                }

        </script>

	</head>
	<body>

    <g:set var="modal" value="none"/>

        <div class="cleared">
            <div style="text-align: center; float: left; width: 240px; background: #ccc; margin: 10px; border: 1px solid #aaa; padding: 5px;">Interventionsebene</div>
            <div style="text-align: center; float: left; width: 240px; background: #ccc; margin: 10px; border: 1px solid #aaa; padding: 5px;">Indikatoren</div>
            <div style="text-align: center; float: left; width: 240px; background: #ccc; margin: 10px; border: 1px solid #aaa; padding: 5px;">ext. Quellennachweise</div>
            <div style="text-align: center; float: left; width: 240px; background: #ccc; margin: 10px; border: 1px solid #aaa; padding: 5px;">Annahmen</div>
        </div>

        <div style="border: 1px solid #33568f; background: #4474c2; margin: 0 0 10px 0; width: 1090px;" class="cleared">
            <div style="background: #cc932e; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                <span class="gray">${subgoal.mainGoal.name}</span>
                <div style="margin: 5px 0;">${subgoal.mainGoal.description}</div>
                %{--<a href="" onclick="setModal(${subgoal.mainGoal.id}, 'description', '${subgoal.mainGoal.description}', 'Oberziel Beschreibung', 'maingoal'); return false;">Bearbeiten</a>--}%
            </div>
            <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                <div>
                    <g:if test="${subgoal.mainGoal.indicator}">
                        ${subgoal.mainGoal.indicator}
                    </g:if>
                    <g:else>
                        <span class="gray">Keine Indikatoren eingetragen!</span>
                    </g:else>
                </div>
                %{--<a href="" onclick="setModal(${subgoal.mainGoal.id}, 'indicator', '${subgoal.mainGoal.indicator}', 'Oberziel Indikatoren', 'maingoal'); return false;">Bearbeiten</a>--}%
            </div>
            <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                <div>
                    <g:if test="${subgoal.mainGoal.sources}">
                        ${subgoal.mainGoal.sources}
                    </g:if>
                    <g:else>
                        <span class="gray">Keine Quellen eingetragen!</span>
                    </g:else>
                </div>
                %{--<a href="" onclick="setModal(${subgoal.mainGoal.id}, 'sources', '${subgoal.mainGoal.sources}', 'Oberziel Quellen', 'maingoal'); return false;">Bearbeiten</a>--}%
            </div>
        </div>

        <div style="border: 1px solid #5b82c2; background: #71a3f5; margin: 0 0 10px 0; width: 1090px;" class="cleared">
                <div style="background: #cc932e; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <span class="gray">${subgoal.name}</span>
                    <div style="margin: 5px 0;">${subgoal.description}</div>
                    <a href="" onclick="setModal(${subgoal.id}, 'description', '${subgoal.description}', 'Ziel Beschreibung', 'subgoal'); return false;">Bearbeiten</a>
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <div>
                        <g:if test="${subgoal.indicator}">
                            ${subgoal.indicator}
                        </g:if>
                        <g:else>
                            <span class="gray">Keine Indikatoren eingetragen!</span>
                        </g:else>
                    </div>
                    <a href="" onclick="setModal(${subgoal.id}, 'indicator', '${subgoal.indicator}', 'Ziel Indikatoren', 'subgoal'); return false;">Bearbeiten</a>
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <div>
                        <g:if test="${subgoal.sources}">
                            ${subgoal.sources}
                        </g:if>
                        <g:else>
                            <span class="gray">Keine Quellen eingetragen!</span>
                        </g:else>
                    </div>
                    <a href="" onclick="setModal(${subgoal.id}, 'sources', '${subgoal.sources}', 'Ziel Quellen', 'subgoal'); return false;">Bearbeiten</a>
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <div>
                        <g:if test="${subgoal.assumptions}">
                            ${subgoal.assumptions}
                        </g:if>
                        <g:else>
                            <span class="gray">Keine Annahmen eingetragen!</span>
                        </g:else>
                    </div>
                    <a href="" onclick="setModal(${subgoal.id}, 'assumptions', '${subgoal.assumptions}', 'Ziel Annahmen', 'subgoal'); return false;">Bearbeiten</a>
                </div>
        </div>

        <g:each in="${subgoal.results}" var="result">
            <div style="border: 1px solid #698f43; background: #8ec25b; margin: 0 0 10px 0; width: 1290px;" class="cleared">
                <div style="background: #cc932e; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <span class="gray">Resultate</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    %{--<g:link action="none">Bearbeiten..</g:link>--}%
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <span class="gray">Indikator Resultate</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    %{--<g:link action="none">Bearbeiten..</g:link>--}%
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <span class="gray">Quelle Resultate</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    %{--<g:link action="none">Bearbeiten..</g:link>--}%
                </div>
                <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                    <span class="gray">Annahme Resultate</span>
                    <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                    %{--<g:link action="none">Bearbeiten..</g:link>--}%
                </div>
                <div class="clear"></div>

                <div style="border: 1px solid #888; background: #ccc; margin: 10px;" class="cleared">
                    <div style="background: #cc932e; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                        <span class="gray">Aktion</span>
                        <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                        %{--<g:link action="none">Bearbeiten..</g:link>--}%
                    </div>
                    <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                        <span class="gray">Ressourcen</span>
                        <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                        %{--<g:link action="none">Bearbeiten..</g:link>--}%
                    </div>
                    <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                        <span class="gray">Kosten</span>
                        <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                        %{--<g:link action="none">Bearbeiten..</g:link>--}%
                    </div>
                    <div style="background: #fff; border: 1px solid #444; padding: 10px; margin: 10px; height: 100px; width: 230px; float: left;">
                        <span class="gray">Voraussetzung</span>
                        <div style="margin: 5px 0;">Lorem ipsum dolor sit amet</div>
                        %{--<g:link action="none">Bearbeiten..</g:link>--}%
                    </div>
                    %{--<g:link class="buttonGreen" style="margin-top: 10px" action="edit">Aktion hinzufügen</g:link>--}%
                </div>

        </div>

        </g:each>
    <g:link class="buttonGreen" style="margin-top: 10px" action="addResult" id="${subgoal.id}">Resultat hinzufügen</g:link>

    <div class="clear"></div>

    <div class="cleared">
        <div style="text-align: center; float: left; width: 100px; background: #4474c2; margin: 20px 20px 0 0; border: 1px solid #33568f; padding: 5px;">Oberziel</div>
        <div style="text-align: center; float: left; width: 100px; background: #71a3f5; margin: 20px 20px 0 0; border: 1px solid #5b82c2; padding: 5px;">Ziel</div>
        <div style="text-align: center; float: left; width: 100px; background: #8ec25b; margin: 20px 20px 0 0; border: 1px solid #698f43; padding: 5px;">Resultat</div>
        <div style="text-align: center; float: left; width: 100px; background: #ccc; margin: 20px 20px 0 0; border: 1px solid #888; padding: 5px;">Aktion</div>
    </div>

    <div id="modalbox" style="display: none;">

        <p id="modaltitle"></p>
        <g:form controller="goal" action="updateElement">
            <g:hiddenField id="hiddenId" name="id" value=""/>
            <g:hiddenField id="hiddenType" name="type" value=""/>
            <g:textArea id="modaltext" rows="20" cols="90" name="none" value=""/><br/>
            <g:submitButton name="button" value="${message(code:'edit')}"/>
        </g:form>

    </div>

	</body>
</html>