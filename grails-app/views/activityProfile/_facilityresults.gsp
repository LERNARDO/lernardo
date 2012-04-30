<script type="text/javascript">

  function kontrolle2(id) {
    var textfield = document.getElementById("hiddentextfield2");
    textfield.value = id;
  }

</script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'activityProfile', action: 'markFacility', id: entity.id]" update="facilities2" before="kontrolle2('${entity.id}');" after="${remoteFunction(action: 'updateEducators', update: 'educators', id: entity.id)} ${remoteFunction(action: 'updateClients', update: 'clients', id: entity.id)}">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold" style="color: #000">${entity.profile.fullName}</span></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>