<div id="subheader">
    <ul>
        <li><g:link class="activegray" controller="event" action="index"><g:message code="start"/></g:link></li>
        <li><a class="activered" href="#" onclick="$('#organisation').hide();
        $('#planning').hide();
        $('#administration').hide();
        $('#database').toggle();
        return false;"><g:message code="database"/></a></li>
        <li><a class="activegreen" href="#" onclick="$('#database').hide();
        $('#planning').hide();
        $('#administration').hide();
        $('#organisation').toggle();
        return false;"><g:message code="organisation"/></a></li>
        <li><a class="activeblue" href="#" onclick="$('#database').hide();
        $('#organisation').hide();
        $('#administration').hide();
        $('#planning').toggle();
        return false;"><g:message code="planning"/></a></li>
        <erp:accessCheck types="['Betreiber']">
            <li><a class="activeyellow" href="#" onclick="$('#database').hide();
            $('#organisation').hide();
            $('#planning').hide();
            $('#administration').toggle();
            return false;"><g:message code="administration"/></a></li>
        </erp:accessCheck>
    </ul>
    <g:render template="/templates/search"/>
    <div class="clear"></div>
</div>

<div id="database" class="new">
    <ul>
        <erp:accessCheck roles="['ROLE_ADMIN']">
            <li class="icon-operator"><g:link controller="operatorProfile" action="list"><g:message code="operator"/></g:link></li>
            <li class="icon-admin"><g:link controller="userProfile" action="list"><g:message code="user"/></g:link></li>
        </erp:accessCheck>
        <li class="icon-educators"><g:link controller="educatorProfile" action="list"><g:message code="educators"/></g:link></li>
        <li class="icon-person"><g:link controller="clientProfile" action="list"><g:message code="clients"/></g:link></li>
        <li class="icon-group"><g:link controller="groupClientProfile" action="list"><g:message code="groupClients"/></g:link></li>
        <li class="icon-group"><g:link controller="groupFamilyProfile" action="list"><g:message code="groupFamilies"/></g:link></li>
        <li class="icon-parents"><g:link controller="parentProfile" action="list"><g:message code="parents"/></g:link></li>
        <li class="icon-child"><g:link controller="childProfile" action="list"><g:message code="children"/></g:link></li>
        <li class="icon-pate"><g:link controller="pateProfile" action="list"><g:message code="paten"/></g:link></li>
        <li class="icon-facility"><g:link controller="facilityProfile" action="list"><g:message code="facilities"/></g:link></li>
        <li class="icon-partner"><g:link controller="partnerProfile" action="list"><g:message code="partners"/></g:link></li>
        <li class="icon-colony"><g:link controller="groupColonyProfile" action="list"><g:message code="groupColonies"/></g:link></li>
    </ul>
</div>

<div id="organisation" class="new">
    <ul>
        <erp:accessCheck types="['Betreiber', 'Pädagoge']">
            <li class="icon-operator"><g:link controller="logBook" action="entries"><g:message code="logBook"/></g:link></li>
        </erp:accessCheck>
    </ul>
</div>

<div id="planning" class="new">
    <ul>
        <li class="icon-template"><g:link controller="templateProfile" action="index"><g:message code="activityTemplates"/></g:link></li>
        %{--<li class="icon-template"><g:link controller="groupActivityTemplateProfile" action="list"><g:message code="groupActivityTemplates"/></g:link></li>--}%
        %{--<li class="icon-activities"><g:link controller="groupActivityProfile" action="list"><g:message code="groupActivities"/></g:link></li>--}%
        %{--<li class="icon-template"><g:link controller="projectTemplateProfile" action="list"><g:message code="projectTemplates"/></g:link></li>--}%
        <li class="icon-template"><g:link controller="projectProfile" action="list"><g:message code="projects"/></g:link></li>
        <li class="icon-template"><g:link controller="themeProfile" action="list"><g:message code="themes"/></g:link></li>
        <li class="icon-template"><g:link controller="goal" action="list">Logframes</g:link></li>
    </ul>
</div>

<div id="administration" class="new">
    <ul>
        <li class="icon-setup"><g:link controller="setup" action="show"><g:message code="setup"/></g:link></li>
        <li class="icon-message"><g:link controller="profile" action="createNotification"><g:message code="notifications"/></g:link></li>
        <li class="icon-time"><g:link controller="timeEvaluation"><g:message code="timeEvaluation"/></g:link></li>
        <li class="icon-evaluation"><g:link controller="evaluation" action="allevaluations"><g:message code="evaluation.allevalentries"/></g:link></li>
        <li class="icon-network"><g:link controller="comment" action="list"><g:message code="comment.management"/></g:link></li>
        <li class="icon-group"><g:link controller="profile" action="list"><g:message code="profile.list"/></g:link></li>
        <li class="icon-resource"><g:link controller="resourceProfile" action="list"><g:message code="resource.management"/></g:link></li>
        <li class="icon-grouppartner"><g:link controller="groupPartnerProfile" action="list"><g:message code="groupPartners"/></g:link></li>
        %{--<li class="icon-resource"><g:link controller="goal" action="list">Marco Logico</g:link></li>--}%
    </ul>
</div>