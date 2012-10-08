<table>
    <g:each in="${method.elements}" var="element" status="i">
      <tr>
        <td style="padding-right: 10px;">${element.name}</td>
        <td style="padding: 5px 0;">
            <div id="element_weighting_${dropdown}_${i}"><g:render template="/templateProfile/weighting_all" model="[i: i, dropdown: dropdown]"/></div>
             %{--<g:select from="${['0':message(code:'m_none'),1:message(code:'m_medium'),'2':message(code:'m_high')]}" name="method${dropdown}lower" noSelection="['all':message(code:'m_all')]" optionKey="key" optionValue="value"/> <g:message code="to"/> <g:select from="${['0':message(code:'m_none'),1:message(code:'m_medium'),'2':message(code:'m_high')]}" name="method${dropdown}upper" noSelection="['all':message(code:'m_all')]" optionKey="key" optionValue="value"/>--}%</td>
      </tr>
    </g:each>
</table>