<g:formRemote name="editBloodType" update="bt${i}" url="[action:'updateBloodType', id: setupInstance.id, params:[bloodTypeOld: bloodType, i: i]]">
  <g:textField size="5" name="bloodType" value="${bloodType}"/> <g:actionSubmitImage value="confirm" src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="${message(code: 'confirm')}" align="top" style="border: 0"/>
</g:formRemote>