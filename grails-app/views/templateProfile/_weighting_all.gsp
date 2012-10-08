<g:hiddenField name="method${dropdown}lower" value="all"/>
<g:hiddenField name="method${dropdown}upper" value="all"/>
<span class="gray"><g:message code="define_any"/></span> <g:remoteLink controller="templateProfile" action="weightingChoose" update="element_weighting_${dropdown}_${i}" params="[i: i, dropdown: dropdown]">(<g:message code="define_orDefine"/>)</g:remoteLink>