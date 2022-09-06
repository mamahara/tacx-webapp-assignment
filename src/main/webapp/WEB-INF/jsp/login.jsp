<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Log in with your account</title>

    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script type="text/javascript" src=" https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.js "></script>
    <style>
        table, input {
            width: auto;
            font: 15px Calibri;
        }
        table, th, td, th {
            border: solid 1px #DDD;
            border-collapse: collapse;
            padding: 2px 3px;
            text-align: center;
            font-weight: normal;
        }
        #camBox{
            display:none;
            position:fixed;
            border:5px;
            top:0;
            right:0;
            left:0;
            overflow-x:auto;
            overflow-y:hidden;
            z-index:9999;
            background-color:rgba(239,239,239,.9);
            width:100%;
            height:100%;
            padding-top:5px;
            text-align:center;
            cursor:pointer;
            -webkit-box-align:center;-webkit-box-orient:vertical;
            -webkit-box-pack:center;-webkit-transition:.2s opacity;
            -webkit-perspective:1000px
        }

        .revdivshowimg{
            width:300px;
            top:0;
            padding:0;
            position:relative;
            margin:0 auto;
            display:block;
            background-color:#fff;
            webkit-box-shadow:6px 0 10px rgba(0,0,0,.2),-6px 0 10px rgba(0,0,0,.2);
            -moz-box-shadow:6px 0 10px rgba(0,0,0,.2),-6px 0 10px rgba(0,0,0,.2);
            box-shadow:6px 0 10px rgba(0,0,0,.2),-6px 0 10px rgba(0,0,0,.2);
            overflow:hidden;
            border-radius:3px;
            color:#17293c
        }
    </style>

</head>

<body>
<div class="overlay"></div>
<!--Main Navigation-->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark default-color-dark fixed-top">
        <a class="navbar-brand" href="/">Chatbot Portal</a>
    </nav>
</header>

<div class="container">

    <form id="login" method="POST" action="${contextPath}/login" class="form-signin">
        <h2 class="form-heading">Log in</h2>

        <div class="form-group ${error != null ? 'has-error' : ''}">
            <span>${message}</span>
            <input name="username" type="text" class="form-control" placeholder="Username"
                   autofocus="true"/>
            <input name="password" type="password" class="form-control" placeholder="Password"/>
            <span>${error}</span>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <button class="btn btn-sm btn-primary btn-block" type="submit">Log In</button>

            <!-- <input class="btn-info btn-sm btn-primary btn-block" type="button" value="Log In Using Face" id="alpha"
                   onclick="preview_snapshot()" /> -->
            <h4 class="text-center"><a href="${contextPath}/registration">Create an account</a></h4>
            <div id="results" style="display:none">
                <!-- Your captured image will appear here... -->
            </div>
        </div>
    </form>
</div>

<div id="camBox" style="width:100%;height:100%;">
    <!--POPUP DIALOG BOX TO SHOW LIVE WEBCAM.-->
    <div class="revdivshowimg" style="top:20%;text-align:center;margin:0 auto;">

        <div id="camera" style="height:auto;text-align:center;margin:0 auto;"></div>
        <form>
            <div id="pre_take_buttons">
                <!-- This button is shown before the user takes a snapshot -->
                <input type=button class="btn-info btn-sm" value="Take Snapshot" onclick="addCamPicture()">
                <input type="button" class="btn-info btn-sm" value="Cancel"
                       onclick="document.getElementById('camBox').style.display = 'none';" />
            </div>
            <div id="post_take_buttons" style="display:none">
                <!-- These buttons are shown after a snapshot is taken -->
                <input type=button class="btn-info btn-sm" value="Take Another" onClick="cancel_preview()">
                <input type=button class="btn-info btn-sm" value="Authenticate" onClick="save_photo()" style="font-weight:bold;">
                <input type="button" class="btn-info btn-sm" value="Cancel"
                       onclick="reset_camera()" />
            </div>
            <input type="hidden" id="rowid" /><input type="hidden" id="dataurl" />
        </form>
    </div>

</div>
    <!-- /container -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
<script language="JavaScript">
    // preload shutter audio clip
    var shutter = new Audio();
    shutter.autoplay = false;
    shutter.src = navigator.userAgent.match(/Firefox/) ? 'shutter.ogg' : 'shutter.mp3';

    function preview_snapshot() {

        Webcam.set({
            width: 320,
            height: 250,
            image_format: 'jpeg',
            jpeg_quality: 100
        });
        Webcam.attach('#camera');

        document.getElementById('camBox').style.display = 'block';
        document.getElementById('rowid').value = oButton.id;
        // play sound effect
        try { shutter.currentTime = 0; } catch(e) {;} // fails in IE
        shutter.play();

        // freeze camera so user can preview current frame
        }

    function cancel_preview() {
        // cancel preview freeze and return to live camera view
        Webcam.unfreeze();

        // swap buttons back to first set
        document.getElementById('pre_take_buttons').style.display = '';
        document.getElementById('post_take_buttons').style.display = 'none';
    }

    function save_photo() {
        // actually snap photo (from preview freeze) and display it
        Webcam.snap( function(data_uri) {
            // display results in page
            //document.getElementById('results').innerHTML =
            //    '<img id="captureImg" src="'+data_uri+'"/><br/></br>';

            //var base64image = document.getElementById("captureImg").src;
            var base64image = data_uri;
            const json_string = {
                "image": base64image
            };
            var imgData = JSON.stringify(json_string);

            $.ajax({
                url: 'http://localhost:5000/face/detect',
                //url: window.location.origin + '/face/detect',
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                data: imgData,
                type: 'POST',
                error: function(xhr, error){
                    alert("Sorry some error Occurred");
                    $("body").removeClass("loading");
                    exit();
                },
                success: function(data) {
                    //var base64_response_image = data['image'];
                    //var image = new Image();
                    //image.src = "data:image/png;base64," + base64_response_image;
                    //document.getElementById('results').innerHTML ='';
                    //document.getElementById("results").appendChild(image);
                    for ( var i = 0; i < data.response.length; i++) {
                        var faceId = data.response[i]['faceId'];
                        const json_faceId = {
                            "faceId": faceId
                        };
                        $.ajax({
                            url: "http://localhost:5000/face/person/identify",
                            //url: window.location.origin + '/face/person/identify',
                            dataType: 'json',
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(json_faceId),
                            type: 'POST',
                            error: function(xhr, error){
                                alert("Sorry some error Occurred");
                                $("body").removeClass("loading");
                            },
                            success: function(response) {
                                var userId = response['userId'];
                                if (userId == "NotFound")
                                    alert("Sorry Authentication failed, Please Register");
                                else
                                    loginPostRequest(userId);
                            }
                        });
                    }
                }
            });

            // shut down camera, stop capturing
            Webcam.reset();
            // show results, hide photo booth
            document.getElementById('pre_take_buttons').style.display = '';
            document.getElementById('post_take_buttons').style.display = 'none';
            document.getElementById('results').style.display = '';
            document.getElementById('camBox').style.display = 'none';

        } );
    }

    addCamPicture = function () {
        Webcam.freeze();
        // swap button sets
        document.getElementById('pre_take_buttons').style.display = 'none';
        document.getElementById('post_take_buttons').style.display = '';

    }

    function loginPostRequest(userId) {
        var http = new XMLHttpRequest();
        var url = "http://localhost:8080/facelogin";
        //var url = window.location.origin + "/facelogin";
        var params = 'username=' + userId;
        http.open('POST', url, true);

//Send the proper header information along with the request
        http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        http.send(params);

        http.onreadystatechange = function() {//Call a function when the state changes.
            if(http.readyState == 4 && http.status == 200) {
                window.location = "http://localhost:8080/welcome";
                //window.location = window.location.origin + "/welcome";
            }
        }
    }

    function reset_camera() {
        // actually snap photo (from preview freeze) and display it
            document.getElementById('pre_take_buttons').style.display = '';
            document.getElementById('post_take_buttons').style.display = 'none';
            document.getElementById('results').style.display = '';
            document.getElementById('camBox').style.display = 'none';

    }

    $(document).on({
        ajaxStart: function(){
            $("body").addClass("loading");
        },
        ajaxStop: function(){
            $("body").removeClass("loading");
        }
    });

</script>
<style>
    .overlay{
        display: none;
        position: fixed;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        z-index: 999;
        background: rgba(255, 255, 255, 0.8) url("${contextPath}/resources/image/loader.gif") center no-repeat;
    }
    body{
        text-align: center;
    }
    /* Turn off scrollbar when body element has the loading class */
    body.loading{
        overflow: hidden;
    }
    /* Make spinner image visible when body element has the loading class */
    body.loading .overlay{
        display: block;
    }
</style>
</html>
