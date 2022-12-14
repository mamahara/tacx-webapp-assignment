<%--
  Created by IntelliJ IDEA.
  User: Manoj.Maharana
  Date: 9/5/2020
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Computer Vision</title>

    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/tabulator.css">
    <script type="text/javascript" src="${contextPath}/resources/js/tabulator.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="${contextPath}/resources/js/sidebar.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/chat.css">
    <script type="text/javascript" src="${contextPath}/resources/js/chat.js"></script>
</head>

<!--Main Navigation-->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark default-color-dark fixed-top">
        <a class="navbar-brand" href="/">Chatbot Portal</a>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <form id="logoutForm" method="POST" action="${contextPath}/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="nav-item">
                        <a style="color:#FFFFFF" href="#">${pageContext.request.userPrincipal.name}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="document.forms['logoutForm'].submit()">Logout</a>
                    </li>
                </ul>
            </div>
        </c:if>
    </nav>
    <nav class="navbar navbar-inverse sidebar navbar-dark default-color-dark" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">Services</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="/">Home<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
                    <li ><a href="/luis">Luis & QNA<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-cloud"></span></a></li>
                    <li ><a href="/vision">Computer Vision<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-eye-open"></span></a></li>
                    <li ><a href="/face-recognition">Face Recognition<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>
                    <li ><a href="/passport-mrz">Face Match & MRZ<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-file"></span></a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<body>
<iframe id="dubaistore" src="http://www.dv-ds.com" frameborder="0" style="width:1050px; height: 530px;"></iframe>>

<div id="live-chat">

    <header class="clearfix">

        <a href="#" class="chat-close">x</a>

        <h4>live Chatbot</h4>

    </header>

    <div class="chat">
        <div id="chat-history" class="chat-history">
            <script src="https://cdn.botframework.com/botframework-webchat/master/webchat.js"></script>

            <div id="webchat" role="main">

                <script>
                    (async function () {
                        const res = await fetch('https://directline.botframework.com/v3/directline/tokens/generate',
                            { method: 'POST',
                                headers: {
                                    'Authorization': 'Bearer  tO8fir7TZFU.DRlIaNmqXtnBcgMtOAsTQNG77KIs6VxA6cuSYuFrD94'
                                }
                            });
                        //const res = await fetch('https://poc-qnabot-app.azurewebsites.net/directline/token', { method: 'POST' });
                        const { token } = await res.json();
                        //const token = 'IchGsdcpMcg.VCB2Y1D0cZE0RqK8KXFjAFFdEYF8ydKLu4490rjU81c';
                        // You can modify the style set by providing a limited set of style options
                        const styleOptions = {

                            botAvatarImage: '${contextPath}/resources/image/WelcomeLogo.png',
                            botAvatarInitials: '',
                            userAvatarImage: '${contextPath}/resources/image/person.png',
                            userAvatarInitials: '',
                            bubbleBackground: 'rgba(0, 0, 255, .1)',
                            bubbleFromUserBackground: 'rgba(0, 255, 0, .1)'
                        };
                        // We are using a customized store to add hooks to connect event
                        const store = window.WebChat.createStore({}, ({ dispatch }) => next => action => {
                            if (action.type === 'DIRECT_LINE/CONNECT_FULFILLED') {
                                // When we receive DIRECT_LINE/CONNECT_FULFILLED action, we will send an event activity using WEB_CHAT/SEND_EVENT
                                dispatch({
                                    type: 'WEB_CHAT/SEND_EVENT',
                                    payload: {
                                        name: 'webchat/join',
                                        value: { language: window.navigator.language }
                                    }
                                });
                            }
                            if (action.type === 'DIRECT_LINE/INCOMING_ACTIVITY') {

                                // Get activity from action
                                const { activity } = action.payload;

                                // Check if the name attribute in the activity is `result`
                                if (activity.name === 'search_event'){
                                    $(document).ready(function(){
                                        reload_url = "http://www.dv-ds.com/search?all-categories-home=&q=" + activity.value;
                                        $('#dubaistore').attr('src', reload_url);
                                    });
                                }
                            }
                            return next(action);
                        });

                        window.WebChat.renderWebChat({
                            directLine: window.WebChat.createDirectLine({ token }),
                            styleOptions,store
                        }, document.getElementById('webchat'));

                        document.querySelector('#webchat > *').focus();
                    })().catch(err => console.error(err));

                </script>
            </div>
        </div> <!-- end chat -->
    </div>

</div> <!-- end live-chat -->

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</html>
