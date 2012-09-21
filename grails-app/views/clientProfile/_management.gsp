<script type="text/javascript">
    $(document).ready(function() {
        $(".datepicker").datepicker({
            monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
                '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
                '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
                '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
            dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                '${message(code: "saturday.short")}'],
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd. mm. yy',
            minDate: new Date(1900, 1, 1),
            firstDay: 1,
            autoSize: true});
    });
</script>

<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="facilities"/> <erp:accessCheck types="['Betreiber','Pädagoge']"><img onclick="toggle('#facilities');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="facilities" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteFacilities" action="remoteFacilities" id="${client.id}" before="showspinner('#remoteFacilities');"/>
        <div id="remoteFacilities"></div>

    </div>
    <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="client.profile.schoolPerformance"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#performances');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="performances" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'clientProfile', action: 'addPerformance', id: client.id]" update="performances2" before="showspinner('#performances2');" after="toggle('#performances'); clearElements(['#performancetext']);">
            <table>
                <tr>
                    <td valign="middle"><g:message code="date"/>:</td>
                    <td><g:datePicker name="date" value="" precision="day"/></td>
                </tr>
                <tr>
                    <td valign="top"><g:message code="text"/>:</td>
                    <td><g:textArea id="performancetext" rows="5" cols="100" name="text" value=""/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><g:submitButton name="button" value="${message(code: 'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
                </tr>
            </table>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="performances2">
        <g:render template="performances" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="client.profile.healthNotes"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#healths');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="healths" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'clientProfile', action: 'addHealth', id: client.id]" update="healths2" before="showspinner('#healths2');" after="toggle('#healths'); clearElements(['#healthstext']);">
            <table>
                <tr>
                    <td valign="middle"><g:message code="date"/>:</td>
                    <td><g:datePicker name="date" value="" precision="day"/></td>
                </tr>
                <tr>
                    <td valign="top"><g:message code="text"/>:</td>
                    <td><g:textArea id="healthstext" rows="5" cols="100" name="text" value=""/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><g:submitButton name="button" value="${message(code: 'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
                </tr>
            </table>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="healths2">
        <g:render template="healths" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="client.profile.materials"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#materials');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="materials" style="display:none">
        <g:formRemote name="formRemote3" url="[controller: 'clientProfile', action: 'addMaterial', id: client.id]" update="materials2" before="showspinner('#materials2');" after="toggle('#materials'); clearElements(['#materialstext']);">
            <table>
                <tr>
                    <td valign="middle"><g:message code="date"/>:</td>
                    <td><g:datePicker name="date" value="" precision="day"/></td>
                </tr>
                <tr>
                    <td valign="top"><g:message code="text"/>:</td>
                    <td><g:textArea id="materialstext" rows="5" cols="100" name="text" value=""/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><g:submitButton name="button" value="${message(code: 'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
                </tr>
            </table>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="materials2">
        <g:render template="materials" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="client.profile.inOut" args="[grailsApplication.config.customerName]"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#dates');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote4" url="[controller: 'clientProfile', action: 'addDate', id: client.id]" update="dates2" before="showspinner('#dates2');" after="toggle('#dates');">
            <g:textField name="date" size="12" class="datepicker" value=""/>
            <g:submitButton name="button" value="${message(code: 'add')}"/>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="schoolEntryExit"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#schooldates');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="schooldates" style="display:none">
        <g:formRemote name="formRemote5" url="[controller: 'clientProfile', action: 'addSchoolDate', id: client.id]" update="schooldates2" before="showspinner('#schooldates2');" after="toggle('#schooldates');">
            <g:message code="date"/> <g:textField id="schooldate" name="date" size="12" class="datepicker" value=""/><br/>
            <g:message code="reason"/> <g:textArea cols="40" rows="5" name="reason" value=""/><br/>
            <g:submitButton name="button" value="${message(code: 'add')}"/>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="schooldates2">
        <g:render template="schooldates" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="client.profile.collectors"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']"><img onclick="toggle('#collectors');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="collectors" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'clientProfile', action: 'addCollector', id: client.id]" update="collectors2" before="showspinner('#collectors2');" after="toggle('#collectors');">
            <g:message code="name"/>: <g:textField size="30" name="name" value=""/> <g:submitButton name="button" value="${message(code: 'add')}"/>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="collectors2">
        <g:render template="collectors" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="educator.profile.emContact"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#contacts');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>

    <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'clientProfile', action: 'addContact', id: client.id]" update="contacts2" before="showspinner('#contacts2');" after="toggle('#contacts');">

            <table>
                <tr>
                    <td><g:message code="firstName"/>:</td>
                    <td><g:textField name="firstName" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="lastName"/>:</td>
                    <td><g:textField name="lastName" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="country"/>:</td>
                    <td><g:textField name="country" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="zip"/>:</td>
                    <td><g:textField name="zip" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="city"/>:</td>
                    <td><g:textField name="city" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="street"/>:</td>
                    <td><g:textField name="street" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="phone"/>:</td>
                    <td><g:textField name="phone" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="email"/>:</td>
                    <td><g:textField name="email" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="contact.function"/>:</td>
                    <td><g:textField name="function" size="30"/></td>
                </tr>
            </table>

            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code: 'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>

    <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="[client: client]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="paten"/></h5>

    <div class="zusatz-show">
        <g:if test="${pates}">
            <ul>
                <g:each in="${pates}" var="pate">
                    <li style="list-style-type: disc; margin-left: 15px"><g:link controller="pateProfile" action="show" id="${pate.id}">${pate.profile.fullName.decodeHTML()}</g:link></li>
                </g:each>
            </ul>
        </g:if>
        <g:else>
            <span class="italic"><g:message code="client.noPateYet"/></span>
        </g:else>
    </div>
</div>