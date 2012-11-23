<g:each in="${calEntities}" var="calEntity" status="i">
  <div class="calenderperson">
    <table style="width: 100%;">
      <tr>
        <td>
          <a style="display: block; text-decoration: none;" href="#" onclick="togglePerson('person','${calEntity.entity.id}','${i}'); return false;">
            <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${calEntity.entity.id}','${i}','${calEntity.visible}');"/>
            <div id="personcolor${i}" style="display: ${calEntity.visible ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${calEntity.color ?: '#ccc'}; background-color: ${calEntity.color ?: '#ccc'};"></div> <erp:truncate length="18" string="${calEntity.entity.profile.fullName}"/></div>
            <div id="personcolor${i}-2" style="display: ${calEntity.visible ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate length="18" string="${calEntity.entity.profile.fullName}"/></div>
          </a>
        </td>
        <td width="35">
          <a href="#" onclick="$('#colored${i}').toggle();"><img class="calendercolorpicker" src="${resource(dir: 'images/icons', file: 'bullet_arrow_down.png')}" alt="options" style="top: 2px; position: relative"/></a>
        </td>
      </tr>
    </table>
  </div>
  <div id="colored${i}" style="display: none; background: #eee; padding: 10px;">
    <g:form controller="calendar" action="updateColor" id="${calEntity.id}">
      <g:textField name="color" value="${calEntity.color ?: '#FFFFFF'}" class="kolorPicker"/>
      <g:submitButton name="submit" value="OK"/>
    </g:form>
    <div class="clear"></div>
    <g:link controller="calendar" action="removeEntity" id="${calEntity.id}"><g:message code="person.remove"/></g:link>
  </div>
</g:each>