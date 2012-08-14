<%@ page import="at.uenterprise.erp.Setup" %>

<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="clients"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#clients');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="clients" style="display:none;">
        <p class="gray"><g:message code="groupClient.clients.info"/></p>
        <g:formRemote name="formRemote0" url="[controller: 'groupClientProfile', action: 'updateselect']" update="clientselect" before="showspinner('#clientselect')">

            <table>
                <tr>
                    <td class="gray" width="125px"><g:message code="name"/></td>
                    <td><g:textField name="name"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="birthDate"/></td>
                    <td class="gray"><g:message code="between"/> <g:datePicker name="birthDate1" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1900}" noSelection="[null:message(code:'all')]" value="none"/> - <g:datePicker name="birthDate2" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1901}" noSelection="[null:message(code:'all')]" value="none"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="gender"/></td>
                    <td><g:select name="gender" from="${['0':message(code:'all'),'1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="groupColony"/></td>
                    <td><g:select name="colony" from="${allColonies}" optionKey="id" optionValue="profile" noSelection="['all':message(code:'all')]"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="facility"/></td>
                    <td><g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile" noSelection="['all':message(code:'all')]"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="client.profile.school"/></td>
                    <td><g:textField name="school"/></td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="client.profile.schoolLevel"/></td>
                    <td>
                        <g:select name="schoolLevel" from="${Setup.list()[0]?.schoolLevels}" noSelection="['all': message(code: 'all')]"/>
                    </td>
                </tr>
                <tr>
                    <td class="gray"><g:message code="client.profile.job"/></td>
                    <td><g:select name="job" from="${['0':message(code:'all'),'1':message(code:'yes'),'2':message(code:'no')]}" optionKey="key" optionValue="value"/></td>
                </tr>
            </table>

            <g:submitButton name="button" value="${message(code:'groupClient.clients.define')}"/>
            <div class="clear"></div>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller: 'groupClientProfile', action: 'addClient', id: group.id]" update="clients2" before="showspinner('#clients2')">
            <div id="clientselect">
                <g:render template="searchresults" model="[allClients: allClients]"/>
            </div>
        </g:formRemote>

    </div>
    <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, group: group]"/>
    </div>
</div>