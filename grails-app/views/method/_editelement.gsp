<g:formRemote name="myForm" url="[action: 'updateElement', id: methodInstance.id, params: [element: element.id, i: i]]" update="element${i}">
  <g:textField size="30" name="name" value="${element.name}"/>
  <g:submitButton name="submit" value="OK"/>
</g:formRemote>
