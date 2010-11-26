  <script type="text/javascript">

  function kontrolle(id) {
    var textfield = document.getElementById("hiddentextfield");
    textfield.value = id;
  }

  </script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'activity', action:'addTemplate', id: entity.id]" update="templates2" before="kontrolle('${entity.id}');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><ub:profileImage name="${entity.name}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold" style="color: #000">${entity.profile.fullName}</span></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>