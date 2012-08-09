<div id="favmodal" style="display: none;">
    <p><g:message code="favorite.selectFolder"/></p>
    <g:formRemote name="formRemote" url="[controller: 'profile', action: 'addFavorite', id: entity.id.toString()]" update="favbutton" before="jQuery('#favmodalinfo').show();">
        <erp:getFolders>
            <g:select name="folder" from="${folders}" optionKey="id" optionValue="name"/>
            <g:submitButton name="button" value="${message(code: 'favorite.add')}"/>
        </erp:getFolders>
    </g:formRemote>
    <div id="favmodalinfo" style="display: none;"><p class="green"><g:message code="favorite.created"/></p></div>
</div>