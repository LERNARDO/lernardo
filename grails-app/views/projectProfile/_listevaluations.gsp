<h4><g:message code="evaluation.evaluation"/></h4>

<div class="boxContent">

    <div class="info-msg">
        <g:message code="object.total" args="[evaluations.size(), message(code: 'evaluation.evaluation')]"/>
    </div>

    <g:each in="${evaluations}" status="i" var="evaluation">
        <div style="border-top: 1px solid #ccc; padding: 10px 0;">
            <p><g:link controller="evaluation" action="show" id="${evaluation.id}">${evaluation.title}</g:link> <g:message code="atDate"/> <g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="about"/> <span class="bold">${evaluation.owner.profile}</span> <g:message code="from"/> ${evaluation.writer.profile}</p>

%{--            <table>
                <tr>
                    <td style="width: 350px; background: #e0e0e0; padding: 10px; border: 1px solid #ccc;"><g:message code="description"/></td>
                    <td style="width: 350px; background: #e0e0e0; padding: 10px; border: 1px solid #ccc;"><g:message code="action"/></td>
                </tr>
                <tr>
                    <td style="background: #eee; padding: 10px; border: 1px solid #ccc;">${evaluation.description.decodeHTML()}</td>
                    <td style="background: #eee; padding: 10px; border: 1px solid #ccc;">${evaluation.method.decodeHTML()}</td>
                </tr>
            </table>--}%

        </div>
    </g:each>

</div>
