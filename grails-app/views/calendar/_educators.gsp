<g:each in="${educators}" var="educator" status="i">
  <erp:getActiveCalPerson id="${educator.id}">
    <div class="calenderperson">
      <table style="width: 100%;">
        <tr>
          <td>
            <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('${educator.id}','${i}'); return false;">
              <div id="personcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${educator.profile.color ?: '#ccc'}; background-color: ${educator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
              <div id="personcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
            </a>
          </td>
        </tr>
      </table>
    </div>
  </erp:getActiveCalPerson>
</g:each>