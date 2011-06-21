<g:formRemote name="formRemote" update="${type + 'element' + i}" url="[action:'updateElement', id: setupInstance.id, params:[elementOld: element, type: type, i: i]]">
  <g:textField size="30" name="element" value="${element.decodeHTML()}"/>
  <g:actionSubmitImage value="confirm" src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="${message(code: 'confirm')}" align="top" style="border: 0"/>
</g:formRemote>