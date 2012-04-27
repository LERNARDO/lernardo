<head>
  <meta name="layout" content="private"/>
  <title>Import/Export</title>
  <export:resource />
</head>

<body>
  <div class="boxHeader">
    <h1>Import/Export</h1>
  </div>

  <div class="boxGray">
    <div class="second">

      Kinder importieren:
      <g:form controller="transfer" action="importChildren" enctype="multipart/form-data">
          <input type="file" name="file" size="50"/>
          <div class="clear"></div>
          <g:submitButton name="submitButton" value="Import"/>
          <div class="clear"></div>
      </g:form>

      Kinder exportieren:
      %{--<export:formats formats="['xml']" action="exportChildren" />--}%
      <div class="clear"></div>
      <g:link class="buttonGreen" action="exportChildren">Export</g:link>
      <div class="clear"></div>
    </div>
  </div>
</body>