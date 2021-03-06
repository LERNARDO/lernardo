<head>
    <meta name="layout" content="planning"/>
    <title><g:message code="project.complete"/></title>
</head>

<body>
<div class="boxHeader">
    <h1><g:message code="project.complete"/></h1>
</div>

<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: project]"/>

    <g:form id="${project.id}">

        <table>

            <tr class="prop">
                <td class="name"><g:message code="project.objectiveReached"/></td>
                <td class="value">
                    <g:checkBox name="objectiveReached"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="project.objectiveComment"/></td>
                <td class="value">
                    <g:textArea name="objectiveComment" rows="5" cols="50"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="project.goodFactors"/></td>
                <td class="value">
                    <g:textArea name="goodFactors" rows="5" cols="50"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="project.badFactors"/></td>
                <td class="value">
                    <g:textArea name="badFactors" rows="5" cols="50"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="project.wouldRepeatIt"/></td>
                <td class="value">
                    <g:checkBox name="wouldRepeatIt"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="project.repeatReason"/></td>
                <td class="value">
                    <g:textArea name="repeatReason" rows="5" cols="50"/>
                </td>
            </tr>

        </table>

        <div class="buttons cleared">
            <div class="button"><g:actionSubmit class="buttonGreen" action="completeNow" value="${message(code: 'save')}"/></div>
            <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}"/></div>
        </div>

    </g:form>

</div>
</body>
