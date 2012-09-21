<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="leadEducators"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#leadeducators');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="leadeducators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteLeadEducators" action="remoteLeadEducators" id="${facility.id}" before="showspinner('#remoteLeadEducators');"/>
        <div id="remoteLeadEducators"></div>

    </div>
    <div class="zusatz-show" id="leadeducators2">
        <g:render template="leadeducators" model="[leadeducators: leadeducators]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="educators"/> <erp:accessCheck types="['Betreiber']" facilities="[facility]"><img onclick="toggle('#educators');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="educators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteEducators" action="remoteEducators" id="${facility.id}" before="showspinner('#remoteEducators');"/>
        <div id="remoteEducators"></div>

    </div>
    <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, facility: facility]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="clients"/> <erp:accessCheck types="['Betreiber']" facilities="[facility]"><img onclick="toggle('#clients');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${facility.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

    </div>
    <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, facility: facility]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="contacts"/> <erp:accessCheck types="['Betreiber']" facilities="[facility]"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#contacts');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'facilityProfile', action: 'addContact', id: facility.id]" update="contacts2" before="showspinner('#contacts2');" after="toggle('#contacts');">

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
                    <td><g:message code="contact.function"/>:</td>
                    <td><g:textField id="cFunction" name="function" size="30"/></td>
                </tr>
            </table>

            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="[facility: facility]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resource.profile"/> <erp:accessCheck types="['Betreiber']" facilities="[facility]"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'facilityProfile', action: 'addResource', id: facility.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
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
                    <td><g:select name="classification" from="${grailsApplication.config.resourceclasses}" value="" valueMessagePrefix="resourceclass"/></td>
                </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, facility: facility]"/>
    </div>
</div>