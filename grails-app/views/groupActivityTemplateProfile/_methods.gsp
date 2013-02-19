<table>
    <g:each in="${method?.elements}" var="element" status="i">
      <tr>
        <td style="padding-right: 10px;">${element.name}</td>
        <td style="padding: 5px 0;">
            <div id="element_weighting_${dropdown}_${i}"><g:render template="/templateProfile/weighting_choose" model="[i: i, dropdown: dropdown, params: params]"/></div>
      </tr>
    </g:each>
</table>