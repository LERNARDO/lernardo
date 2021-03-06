<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="representatives"/> <erp:accessCheck types="['Betreiber']"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#representatives');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/>
    </a></erp:accessCheck></h5>
    <div class="zusatz-add" id="representatives" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'groupColonyProfile', action: 'addRepresentative', id: group.id]" update="representatives2" before="showspinner('#representatives2');" after="toggle('#representatives');">

            <table>
                <tr>
                    <td><g:message code="firstName"/>: <span class="required-indicator">*</span></td>
                    <td><g:textField required="" id="cFirstName" size="30" name="firstName" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="lastName"/>: <span class="required-indicator">*</span></td>
                    <td><g:textField required="" id="cLastName" size="30" name="lastName" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="country"/>:</td>
                    <td><g:textField id="cCountry" size="30" name="country" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="zip"/>:</td>
                    <td><g:textField id="cZip" size="30" name="zip" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="city"/>:</td>
                    <td><g:textField id="cCity" size="30" name="city" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="street"/>:</td>
                    <td><g:textField id="cStreet" size="30" name="street" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="phone"/>:</td>
                    <td><g:textField id="cPhone" size="30" name="phone" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="email"/>:</td>
                    <td><g:textField id="cEmail" size="30" name="email" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="contact.function"/>:</td>
                    <td><g:textField id="cFunction" size="30" name="function" value=""/></td>
                </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="representatives2">
        <g:render template="representatives" model="[group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resource.profile"/> <erp:accessCheck types="['Betreiber']"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote4" url="[controller: 'groupColonyProfile', action: 'addResource', id: group.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
            <table>
                <tr>
                    <td><g:message code="name"/>:</td>
                    <td><g:textField id="resourceName" size="30" name="fullName" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="description"/>:</td>
                    <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.amount"/>:</td>
                    <td><g:textField id="resourceAmount" size="5" name="amount" value="1"/></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.costs"/>:</td>
                    <td><g:textField id="resourceCosts" size="5" name="costs" value="0"/> <span class="gray">${grailsApplication.config.currency}</span></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.costsUnit"/>:</td>
                    <td><g:select name="costsUnit" from="${grailsApplication.config.costsUnit}" value="" valueMessagePrefix="costsUnit"/></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.classification"/>:</td>
                    <td>
                        <g:select name="classification" from="${grailsApplication.config.resourceclasses}" value="" valueMessagePrefix="resourceclass"/>
                    </td>
                </tr>
            </table>

            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="facilities"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#facilities');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="facilities" style="display:none">
        <p class="gray"><g:message code="groupColony.facilityNote"/></p>
        <g:formRemote name="formRemote3" url="[controller: 'groupColonyProfile', action: 'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2');" after="toggle('#facilities');">
            <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="partners"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#partners');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller: 'groupColonyProfile', action: 'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2');" after="toggle('#partners');">
            <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group]"/>
    </div>
</div>