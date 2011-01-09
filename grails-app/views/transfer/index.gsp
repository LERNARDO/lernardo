<head>
  <meta name="layout" content="private"/>
  <title>Import/Export</title>
  <export:resource />
</head>

<body>
  <div class="headerGreen">
    <div class="second">
      <h1>Import/Export</h1>
    </div>
  </div>

  <div class="boxGray">
    <div class="second">

      Kinder importieren:
      <g:form controller="transfer" action="importChildren" enctype="multipart/form-data">
          <input type="file" name="file" size="50"/>
          <div class="spacer"></div>
          <g:submitButton name="submitButton" value="Import"/>
          <div class="spacer"></div>
      </g:form>

      Kinder exportieren:
      %{--<export:formats formats="['xml']" action="exportChildren" />--}%
      <div class="spacer"></div>
      <g:link class="buttonGreen" action="exportChildren">Export</g:link>
      <div class="spacer"></div>
    </div>
  </div>
</body>