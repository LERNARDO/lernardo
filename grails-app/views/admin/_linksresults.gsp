<div>Entities linked to from <span class="bold">${entity.profile.fullName}</span> (source):</div>
<g:if test="${targets}">
    <ul>
        <g:each in="${targets}" var="target" status="i">
            <li id="target${i}"><g:remoteLink update="target${i}" action="removetarget" id="${target.target.id}" params="[entity: entity.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'delete')}" align="top"/></g:remoteLink> ${target.target.profile.fullName} (<span class="bold">${target.target.type.name}</span>) - Linktyp: "${target.type.name}"</li>
        </g:each>
    </ul>
</g:if>
<g:else>
    <p class="red"><g:message code="links.notFound"/></p>
</g:else>
<div>Entities linking to <span class="bold">${entity.profile.fullName}</span> (target):</div>
<g:if test="${sources}">
    <ul>
        <g:each in="${sources}" var="source" status="i">
            <li id="source${i}"><g:remoteLink update="source${i}" action="removesource" id="${source.source.id}" params="[entity: entity.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'delete')}" align="top"/></g:remoteLink> ${source.source.profile.fullName} (<span class="bold">${source.source.type.name}</span>) - Linktyp: "${source.type.name}"</li>
        </g:each>
    </ul>
</g:if>
<g:else>
    <p class="red"><g:message code="links.notFound"/></p>
</g:else>
