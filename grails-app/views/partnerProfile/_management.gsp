<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="partner.profile.contacts"/> <erp:accessCheck types="['Betreiber']"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#contacts');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'partnerProfile', action: 'addContact', id: partner.id]" update="contacts2" before="showspinner('#contacts2');" after="toggle('#contacts');">

            <table>
                <tr>
                    <td><g:message code="firstName"/>:</td>
                    <td><g:textField id="cFirstName" name="firstName" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="lastName"/>:</td>
                    <td><g:textField id="cLastName" name="lastName" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="country"/>:</td>
                    <td><g:textField id="cCountry" name="country" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="zip"/>:</td>
                    <td><g:textField id="cZip" name="zip" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="city"/>:</td>
                    <td><g:textField id="cCity" name="city" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="street"/>:</td>
                    <td><g:textField id="cStreet" name="street" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="phone"/>:</td>
                    <td><g:textField id="cPhone" name="phone" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="email"/>:</td>
                    <td><g:textField id="cEmail" name="email" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="partner.profile.contactFunction"/>:</td>
                    <td><g:textField id="cFunction" name="function" size="30"/></td>
                </tr>
            </table>

            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="[partner: partner]"/>
    </div>
</div>