  <head>
    <title>Mitglieder</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
  </head>

  <body>
    <div class="yui-g" id="members">
        <h1>Mein Netzwerk</h1>

        <g:if test="${friendsList}">
          <g:render template="memberlist" model="[cssclass:'myfriends', title:'Meine Freunde',
                    emptyMsg:'noch keine Freunde', entities:friendsList]"/>
        </g:if>

        <g:if test="${clientsList}">
          <g:render template="memberlist" model="[cssclass:'myemployers', title:'Meine Betreuten',
                    emptyMsg:'noch keine Betreuten', entities:clientsList]"/>
        </g:if>

        <g:if test="${bookmarksList}">
          <g:render template="memberlist" model="[cssclass:'mymemberships', title:'Meine Bookmarks',
                    emptyMsg:'noch keine Bookmarks', entities:bookmarksList]"/>
        </g:if>

    </div><!-- END yui-g -->
  </body>