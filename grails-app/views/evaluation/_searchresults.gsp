<script type="text/javascript">
    function setHiddenId(id) {
        $('#hiddenEntityId').val(id);
    }
</script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'evaluation', action: 'addResult', id: entity.id]" update="selected" before="setHiddenId('${entity.id}');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65" height="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;">
              <span class="bold" style="color: #000">${entity.profile}</span><br/>
              <g:message code="${entity.type.supertype.name}"/><br/>
              <g:if test="${entity.type.supertype.name == 'projectUnit'}">
                <erp:getProjectOfUnit unit="${entity}"/>
              </g:if>
            </td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>