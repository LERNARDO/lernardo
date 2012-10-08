  <script type="text/javascript">

  function kontrolle1(id) {
    var textfield = document.getElementById("hiddentextfield1");
    textfield.value = id;
  }

  </script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'activityProfile', action: 'addTemplate', id: entity.id]" update="templates2" before="kontrolle1('${entity.id}');">
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