<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityTemplates"/></title>
</head>

<body>

%{--<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong"><g:message code="hint"/></span> <g:message code="activityTemplate.list.hint"/>
    </div>
  </div>
</g:if>--}%

<div class="headerGreen">
  <div class="second">
    <h1><g:message code="activityTemplates"/></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="frame" style="border: 1px solid #aaa; padding: 5px; margin-bottom: 5px;">
      <p>Die Aktivitätsvorlagen können nach folgenden Merkmalen eingegrenzt werden: (max. 30 Treffer werden angezeigt!)</p>
      <g:formRemote name="formRemote0" url="[controller:'templateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect')">

        <table>
          <tr>
            <td>Name:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td>Dauer:</td>
            <td><g:select from="${1..239}" name="duration1" noSelection="['all':'Beliebig']" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
              <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
          </tr>
          <tr>
            <td style="vertical-align: top">Bewertungsmethode 1:</td>
            <td>
              <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
              <div id="elements1"></div>
            </td>
          </tr>
          <tr>
            <td style="vertical-align: top">Bewertungsmethode 2:</td>
            <td>
              <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
              <div id="elements2"></div>
            </td>
          </tr>
          <tr>
            <td style="vertical-align: top">Bewertungsmethode 3:</td>
            <td>
              <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
              <div id="elements3"></div>
            </td>
          </tr>
        </table>

        <g:submitButton name="button" value="Eingrenzen"/>
        <div class="spacer"></div>
      </g:formRemote>
    </div>

    <div id="templateselect">
      <g:render template="searchresults" model="[allTemplates: allTemplates, currentEntity: currentEntity]"/>
    </div>

  </div>
</div>
</body>