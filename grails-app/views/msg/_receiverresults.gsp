  <script type="text/javascript">

  function checkIt(id, name) {
    var select = document.getElementById("hiddenselect");

    var clean = true;
    for (var i = 0; i < select.options.length; i++) {
        if (select.options[i].value == id) {
            clean = false;
            break
        }
    }

    if (clean) {
        var optn = document.createElement("OPTION");
        optn.text = id;
        optn.value = id;
        optn.selected = true;
        select.options.add(optn);

        var text = document.getElementById("receivers2");
        $('#receivers2').append('<div>' + name + '</div>');
    }
  }

  </script>

<g:if test="${results}">
  <div class="remoteresults" style="width: 535px">
    <g:each in="${results}" var="entity">
      %{--<g:remoteLink url="[controller:'msg', action:'addReceiver', id: entity.id]" update="receivers2" before="kontrolle2('${entity.id}');" after="addReceiver('${entity.profile.fullName}');">--}%
      <div class="remoteresult" onclick="checkIt('${entity.id}','${entity.profile.fullName}');">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold" style="color: #000">${entity.profile.fullName}</span></td>
          </tr>
        </table>
      </div>
      %{--</g:remoteLink>--}%
    </g:each>
  </div>
</g:if>