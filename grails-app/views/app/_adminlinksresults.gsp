<div>Entitäten auf die <span class="bold">${entity.profile.fullName}</span> verlinkt (source):</div>
<g:if test="${targets}">
    <ul>
        <g:each in="${targets}" var="target" status="i">
            <li id="target${i}"><g:remoteLink update="target${i}" action="removetarget" id="${target.id}" params="[entity: entity.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'delete')}" align="top"/></g:remoteLink> ${target.profile.fullName} (<span class="bold">${target.type.name}</span>)</li>
        </g:each>
    </ul>
</g:if>
<g:else>
    <p class="red">Keine Verlinkungen gefunden</p>
</g:else>
<div>Entitäten die auf <span class="bold">${entity.profile.fullName}</span> verlinken (target):</div>
<g:if test="${sources}">
    <ul>
        <g:each in="${sources}" var="source" status="i">
            <li id="source${i}"><g:remoteLink update="source${i}" action="removesource" id="${source.id}" params="[entity: entity.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'delete')}" align="top"/></g:remoteLink> ${source.profile.fullName} (<span class="bold">${source.type.name}</span>)</li>
        </g:each>
    </ul>
</g:if>
<g:else>
    <p class="red">Keine Verlinkungen gefunden</p>
</g:else>
