<%@ page import="at.uenterprise.erp.Method; at.uenterprise.erp.Label; at.uenterprise.erp.base.Entity" %>
<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="activityTemplates"/></title>
</head>

<body>

<div class="boxHeader">
  <h1><g:message code="activityTemplates"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

  <div class="info-msg">
    <g:message code="object.total" args="[totalTemplates, message(code: 'activityTemplates')]"/>
  </div>

  <div class="buttons cleared">
      <erp:accessCheck types="['Pädagoge','Betreiber']">
          <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'activityTemplate')])}"/></div>
          </g:form>
      </erp:accessCheck>
  </div>

  <div class="graypanel">
    <g:formRemote name="formRemote" url="[controller: 'templateProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="creator"/></td>
          <td class="value">
              <g:remoteField size="40" name="remoteField1" update="remoteCreators" controller="profile" action="remoteCreators" before="showspinner('#remoteCreators')"/>
              <div id="remoteCreators"></div>
              <g:hiddenField name="creator" id="hiddenCreatorId" value="${params?.creator}"/>
            <span id="creators2">
              <g:if test="${params?.creator}">
                  <%
                      Entity creator = Entity.get(params?.creator?.toInteger())
                  %>
                  ${creator.profile}
              </g:if>
              <g:else>
                <g:message code="none"/>
              </g:else>
          </span> <a href="" onclick="jQuery('#creators2').html('${message(code: 'none')}'); clearElements(['#hiddenCreatorId']); return false"><img src="${g.resource(dir:'images/icons', file:'cross.png')}" alt="Delete"/></a>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField name="name" size="30" value="${params?.name}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="duration"/></td>
          <td class="value">
            <g:select from="${1..239}" name="duration1" value="${params?.duration1?.toInteger()}" noSelection="['0':message(code:'any')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'secondselect', update: 'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
            <span id="secondSelect">
              <g:if test="${params?.duration2}">
                  bis <g:select from="${params?.duration1?.toInteger()..240}" name="duration2" id="duration2" value="${params?.duration2?.toInteger()}"/>
              </g:if>
              <g:else>
                <span id="duration2" style="display: none">0</span></span> (min)
              </g:else>
          </td>
        </tr>

          <%
              List labels = []
              params?.list('labels')?.each {
                  labels.add(Label.findByName(it))
              }
          %>
        <tr class="prop">
          <td class="name"><g:message code="labels"/></td>
          <td class="value">
            <g:select from="${allLabels}" multiple="true" name="labels" value="${labels}" style="min-height: 115px;"/>
              <g:radioGroup name="labelLogic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="${params?.labelLogic?.toInteger() ?: 1}">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="age"/></td>
          <td class="value">
            <span class="gray"><g:message code="from"/></span> <g:textField name="ageFrom" size="5" value="${params?.ageFrom}"/> <span class="gray"><g:message code="to"/></span> <g:textField name="ageTo" size="5" value="${params?.ageTo}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 1</td>
          <td class="value">
              <%
                  def method1 = Method.get(params?.method1?.toInteger())
              %>
            <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" value="${method1?.id}" noSelection="['0':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
              <g:radioGroup name="method1Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="${params?.method1Logic?.toInteger() ?: 2}">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements1">
                  <g:if test="${method1}">
                      <g:render template="/groupActivityTemplateProfile/methods" model="[method: method1, dropdown: '1', params: params]"/>
                  </g:if>
              </div>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 2</td>
          <td class="value">
              <%
                  def method2 = Method.get(params?.method2?.toInteger())
              %>
            <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" value="${method2?.id}" noSelection="['0':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
              <g:radioGroup name="method2Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="${params?.method2Logic?.toInteger() ?: 2}">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements2">
                  <g:if test="${method2}">
                      <g:render template="/groupActivityTemplateProfile/methods" model="[method: method2, dropdown: '2', params: params]"/>
                  </g:if>
              </div>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="vMethod"/> 3</td>
          <td class="value">
              <%
                  def method3 = Method.get(params?.method3?.toInteger())
              %>
            <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" value="${method3?.id}" noSelection="['0':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
              <g:radioGroup name="method3Logic" labels="[message(code: 'AND'), message(code: 'OR')]" values="[1,2]" value="${params?.method3Logic?.toInteger() ?: 2}">
                  <span>${it.radio} ${it.label}</span>
              </g:radioGroup>
              <div id="elements3">
                  <g:if test="${method3}">
                      <g:render template="/groupActivityTemplateProfile/methods" model="[method: method3, dropdown: '3', params: params]"/>
                  </g:if>
              </div>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
      <div class="clear"></div>
    </g:formRemote>
  </div>

  <div id="searchresults"></div>

</div>
</body>