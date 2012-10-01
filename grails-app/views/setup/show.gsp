<head>
    <meta name="layout" content="administration"/>
    <title>Setup</title>
</head>

<body>

<div class="tabGreen">
    <div class="second">
        <h1>Setup</h1>
    </div>
</div>

<div class="tabGrey">
    <div class="second">
        <h1><g:link controller="method" action="index"><g:message code="vMethods"/></g:link></h1>
    </div>
</div>

<div class="tabGrey">
    <div class="second">
        <h1><g:link controller="label" action="index"><g:message code="labels"/></g:link></h1>
    </div>
</div>

<div class="clear"></div>

<div class="boxGray">

    <div class="setup">
        <ul>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'general']" before="showspinner('#content')"><g:message
                    code="general"/></g:remoteLink></li>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'educators']" before="showspinner('#content')"><g:message
                    code="educators"/></g:remoteLink></li>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'clients']" before="showspinner('#content')"><g:message
                    code="clients"/></g:remoteLink></li>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'parents']" before="showspinner('#content')"><g:message
                    code="parents"/></g:remoteLink></li>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'partners']" before="showspinner('#content')"><g:message
                    code="partners"/></g:remoteLink></li>
            <li><g:remoteLink action="showSection" update="content" id="${setupInstance.id}" params="[type: 'families']" before="showspinner('#content')"><g:message
                    code="groupFamilies"/></g:remoteLink></li>
        </ul>
        <div class="clear"></div>
    </div>

    <div id="content"></div>

</div>
</body>

