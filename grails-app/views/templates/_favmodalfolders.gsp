<erp:getFolders>
    <p><g:message code="favorite.addFolder"/></p>
    <g:formRemote name="formRemote" url="[controller: 'favorite', action: 'saveFolderModal', id: entity.id]" update="favmodal" before="showspinner('#favmodal');">
        <table>
            <tr>
                <td class="gray"><g:message code="name"/></td>
                <td><g:textField name="name"/></td>
            </tr>
            <tr>
                <td class="gray"><g:message code="description"/></td>
                <td><g:textField name="description"/></td>
            </tr>
            <tr>
                <td class="gray"><g:message code="folder"/></td>
                <td><g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['none': 'keiner']"/></td>
            </tr>
        </table>
        <g:submitButton name="button" value="${message(code:'add')}"/>
    </g:formRemote>
    <p style="margin-top: 10px;"><g:message code="favorite.selectFolder"/></p>
    <g:formRemote name="formRemote" url="[controller: 'profile', action: 'addFavorite', id: entity.id.toString()]" update="favbutton" before="jQuery('#favmodalinfo').show();">
        <g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['null': 'Root']"/>
        <g:submitButton name="button" value="${message(code: 'favorite.add')}"/>
    </g:formRemote>
    <div id="favmodalinfo" style="display: none;"><p class="green"><g:message code="favorite.created"/></p></div>
</erp:getFolders>