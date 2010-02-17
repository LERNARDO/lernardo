<head>
  <title>Lernardo | Netzwerk</title>
  <meta name="layout" content="private" />
</head>

<body>
  <div class="headerBlue">
    <h1>Netzwerk</h1>
  </div>
  <div class="boxGray">
    <div class="yui-g" id="members">

        <g:render template="memberList" model="[cssclass:'myfriends', title:'Meine Freunde',
                  emptyMsg:'Du hast derzeit noch keine Freunde', entities:friendsList]"/>

        <g:render template="memberList" model="[cssclass:'myemployers', title:'Meine Betreuten',
                  emptyMsg:'Du hast derzeit noch keine Betreuten!', entities:clientsList]"/>

        <g:render template="memberList" model="[cssclass:'mymemberships', title:'Meine Bookmarks',
                  emptyMsg:'Du hast derzeit noch keine Bookmarks!', entities:bookmarksList]"/>

    </div>
  </div>
</body>