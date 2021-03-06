<%@ page import="at.uenterprise.erp.Setup" %>
<head>
    <meta name="layout" content="database"/>
    <title><g:message code="object.create" args="[message(code: 'groupFamily')]"/></title>
</head>

<body>
<div class="boxHeader">
    <h1><g:message code="object.create" args="[message(code: 'groupFamily')]"/></h1>
</div>

<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form>

        <table>

            <tr class="prop">
                <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
                <td class="value">
                    <g:textField data-counter="50" class="${hasErrors(bean: group, field: 'profile', 'errors')}"
                                 required="" size="30" name="fullName"
                                 value="${fieldValue(bean: group, field: 'profile').decodeHTML()}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.familyIncome"/></td>
                <td class="value">
                    <g:textField class="${hasErrors(bean: group, field: 'profile.familyIncome', 'errors')}" size="5"
                                 name="familyIncome" value="${fieldValue(bean: group, field: 'profile.familyIncome')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.amountHousehold"/></td>
                <td class="value">
                    <g:textField class="${hasErrors(bean: group, field: 'profile.amountHousehold', 'errors')}" size="5"
                                 name="amountHousehold"
                                 value="${fieldValue(bean: group, field: 'profile.amountHousehold')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.livingConditions"/></td>
                <td class="value">
                    <g:textArea data-counter="500"
                                class="${hasErrors(bean: group, field: 'profile.livingConditions', 'errors')}"
                            rows="5" cols="36" name="livingConditions"
                            value="${fieldValue(bean: group, field: 'profile.livingConditions')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.socioeconomicData"/></td>
                <td class="value">
                    <g:textArea data-counter="500"
                                class="${hasErrors(bean: group, field: 'profile.socioeconomicData', 'errors')}"
                            rows="5" cols="36" name="socioeconomicData"
                            value="${fieldValue(bean: group, field: 'profile.socioeconomicData')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.otherInfo"/></td>
                <td class="value">
                    <g:textArea data-counter="500" class="${hasErrors(bean: group, field: 'profile.otherInfo', 'errors')}"
                                rows="5" cols="36" name="otherInfo"
                                value="${fieldValue(bean: group, field: 'profile.otherInfo')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td class="name"><g:message code="groupFamily.profile.familyProblems"/></td>
                <td class="value">
                    <g:select name="familyProblems" from="${Setup.list()[0]?.familyProblems}"
                              value="${group?.profile?.familyProblems}" noSelection="['': message(code: 'none')]"/>
                </td>
            </tr>

        </table>

        <div class="buttons cleared">
            <div class="button"><g:actionSubmit class="buttonGreen" action="save"
                                                value="${message(code: 'save')}"/></div>
            <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
        </div>

    </g:form>

</div>
</body>