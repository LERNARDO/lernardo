<table>

<g:each in="${method.elements}" var="element">
  <tr>
    <td><span class="bold">${element.name}</span></td>
    <td><g:select from="${['0':message(code:'m_none'),1:message(code:'m_low'),'2':message(code:'m_mediumlow'),'3':message(code:'m_medium'),'4':message(code:'m_mediumhigh'),'5':message(code:'m_high')]}" name="method${dropdown}lower" noSelection="['all':message(code:'m_all')]" optionKey="key" optionValue="value"/> <g:message code="to"/> <g:select from="${['0':message(code:'m_none'),1:message(code:'m_low'),'2':message(code:'m_mediumlow'),'3':message(code:'m_medium'),'4':message(code:'m_mediumhigh'),'5':message(code:'m_high')]}" name="method${dropdown}upper" noSelection="['all':message(code:'m_all')]" optionKey="key" optionValue="value"/></td>
  </tr>
</g:each>

</table>