<table>

<g:each in="${method.elements}" var="element">
  <tr>
    <td><span class="bold">${element.name}</span></td>
    <td><g:select from="${['0':'kein',1:'niedrig','2':'mittelniedrig','3':'mittel','4':'mittelhoch','5':'hoch']}" name="method${dropdown}lower" noSelection="['all':'Jede']" optionKey="key" optionValue="value"/> bis <g:select from="${['0':'kein',1:'niedrig','2':'mittelniedrig','3':'mittel','4':'mittelhoch','5':'hoch']}" name="method${dropdown}upper" noSelection="['all':'Jede']" optionKey="key" optionValue="value"/></td>
  </tr>
</g:each>

</table>