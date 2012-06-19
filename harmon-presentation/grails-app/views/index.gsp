<html>
    <head>
        <title>Welcome to Grails</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">

        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        </style>
    </head>
    <body>
        <div id="pageBody">

            <div id="controllerList" class="dialog">
            	<h1>Harmon</h1>
                <ul>
                	<li><g:link controller="room">Pokoje</g:link></li>
                	<li><g:link controller="building">Budynki</g:link></li>
                	<li><g:link controller="lecturer">Prowadzacy</g:link></li>
                	<li><g:link controller="subject">Przedmioty</g:link></li>
                	<li><g:link controller="group">Grupy</g:link></li>
                	<li><g:link controller="dateGroup">Personalizacja kalendarza</g:link></li>
                	<li><g:link controller="term">Terminy</g:link></li>
                	<li><g:link controller="ticket">Zajecia</g:link></li>
                    <li><g:link controller="ticket" action="calendar">Kalendarz</g:link></li>
                </ul>
            </div>
        </div>
    </body>
</html>
