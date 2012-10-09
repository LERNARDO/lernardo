<script type="text/javascript">
    function setHiddenId(id) {
        $('#hiddenCreatorId').val(id);
    }
</script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'profile', action: 'addCreator', id: entity.id]" update="creators2" before="setHiddenId('${entity.id}');">
        <div class="remoteresult">
          <table>
            <tr>
              <td><erp:profileImage entity="${entity}" width="65"/></td>
              <td style="vertical-align: top; padding-left: 5px;"><span class="bold" style="color: #000">${entity.profile}</span></td>
            </tr>
          </table>
        </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>