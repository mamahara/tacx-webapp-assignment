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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome</title>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <link href="${contextPath}/resources/css/common.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/tabulator.css">
    <script type="text/javascript" src="${contextPath}/resources/js/tabulator.js"></script>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.min.js"></script>
    <!------ Include the above in your HEAD tag ---------->
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
                    <li ><a href="/speech-api">Speech Service<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-volume-up"></span></a></li>
                    <li ><a href="/passport-mrz">Face Match & MRZ<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-file"></span></a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>
<body onload="preview_snapshot()">

<div class="container">
        <div class="row">
            <div id="initial-camera" class="col-md-6">
                <div id="my_camera"></div>
                <br/>
                <input type=button class="btn-sm center-block btn-info" value="Take Snapshot" onClick="take_snapshot()">
                <input type="hidden" name="image" class="image-tag">
            </div>
                <div id="face_buttons" class="col-md-6" style="display: none">
                <div id="results"></div>
                <br/>
                <input type=button class="btn-sm btn-info" value="Take Snapshot" onClick="preview_snapshot()">
                <input type="hidden" name="image" class="image-tag">
                <button class="btn btn-success" onClick="detect_face()">Detect Faces</button>
                <button class="btn btn-success" onClick="register_face()">Register Your Face</button>
                <button class="btn btn-success" onClick="identify_faces()">Identify Persons</button>
                </div>

                <div id="face_report" class="col-md-6" style="display: none">
                    <div id="face_report_data"></div>
                </div>
        </div>
</div>

<!-- Configure a few settings and attach camera -->
<script language="JavaScript">

    var captured_uri = '';

    function preview_snapshot() {
        Webcam.set({
            width: 490,
            height: 390,
            image_format: 'jpeg',
            jpeg_quality: 100
        });
        Webcam.attach( '#my_camera' );
        $("#face_buttons").hide();
        $("#initial-camera").show();
        document.getElementById('face_report_data').innerHTML ='';
    }

    function take_snapshot() {
        Webcam.snap( function(data_uri) {
            captured_uri = data_uri;
            $(".image-tag").val(data_uri);
            document.getElementById('results').innerHTML = '<img src="'+data_uri+'"/>';
            $("#face_buttons").show();
            $("#initial-camera").hide();
            $("#face_report").hide();
            Webcam.reset();
        } );
    }

    function detect_face() {
        document.getElementById('face_report_data').innerHTML ='';
        var base64image = captured_uri;
        const json_string = {
            "image": base64image
        };
        var imgData = JSON.stringify(json_string);
        $.ajax({
            url: 'http://localhost:5000/face/detect',
            //url: window.location.origin + "/face/detect",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: imgData,
            type: 'POST',
            error: function(xhr, error){
                alert("Sorry some error Occurred");
                exit();
            },
            success: function(data) {
                document.getElementById('results').innerHTML ='';
                var h3 = document.createElement("H3");
                var t3 = document.createTextNode(data.response.length + " Face Detected As Below");
                h3.appendChild(t3);
                document.getElementById("face_report_data").appendChild(h3);

                var image = new Image();
                var base64_response_image = data.response[0]['image'];
                image.src = "data:image/png;base64," + base64_response_image;


                for ( var i = 0; i < data.response.length; i++) {
                    var faceId = data.response[i]['faceId'];
                    if (faceId == "NA"){
                        $("#face_report").show();
                        document.getElementById('face_report_data').innerHTML ='';
                        var h2 = document.createElement("H2");
                        var t3 = document.createTextNode("No Face Detected");
                        h2.appendChild(t3);
                        document.getElementById("face_report_data").appendChild(h2);
                    }
                    else{
                        var row1 = document.createElement("tr");
                        var r1 = document.createTextNode("FaceId : " + data.response[i]['faceId']);
                        row1.appendChild(r1)
                        document.getElementById("face_report_data").appendChild(row1);

                        var row1 = document.createElement("tr");
                        var r1 = document.createTextNode("Age : " + data.response[i]['age']);
                        row1.appendChild(r1)
                        document.getElementById("face_report_data").appendChild(row1);

                        var row1 = document.createElement("tr");
                        var r1 = document.createTextNode("Gender : " + data.response[i]['gender']);
                        row1.appendChild(r1)
                        document.getElementById("face_report_data").appendChild(row1);

                        var row1 = document.createElement("tr");
                        var r1 = document.createTextNode("Smile : " + data.response[i]['smile']);
                        row1.appendChild(r1)
                        document.getElementById("face_report_data").appendChild(row1);

                        var row1 = document.createElement("tr");
                        var r1 = document.createTextNode("Glasses : " + data.response[i]['glasses']);
                        row1.appendChild(r1)
                        document.getElementById("face_report_data").appendChild(row1);

                        var row1 = document.createElement("br");

                        document.getElementById("face_report_data").appendChild(row1);

                    }
                }
            }
        });
    }

    function register_face() {
        document.getElementById('face_report_data').innerHTML ='';
        var base64image = captured_uri;
        var userId = "anonymousUser";
        var personId = "null";
        var person_group_id = "users"
        var persisted_face_id = "null";
        var fullName = "";

        $.ajax({
            url: 'http://localhost:8080/getLoggedInUserDetails',
            //url: window.location.origin + "/getLoggedInUserDetails",
            dataType: 'json',
            async: false,
            contentType: "application/json; charset=utf-8",
            type: 'GET',
            error: function(xhr, error){
                alert("Sorry some error Occurred");
                exit();
            },
            success: function(data) {
                 userId = data.username;
                 personId = data.personId;
                 fullName = data.fullName;
            }
        });
        const json_string = {
            "image": base64image,
            "userId" : userId,
            "person_group_id": person_group_id,
            "personId": personId
        };
        var imgData = JSON.stringify(json_string);

        if (userId == "anonymousUser"){
            alert("Please login First");
            exit();
        }
        else{
            $.ajax({
                url: 'http://localhost:5000/face/person/create',
                //url: window.location.origin + "/face/person/create",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                data: imgData,
                type: 'POST',
                error: function(xhr, error){
                    alert("Sorry some error Occurred");
                    exit();
                },
                success: function(data) {
                    persisted_face_id = data['persisted_face_id'];
                    personId = data['personId'];

                    var url = "http://localhost:8080/updateLoggedInUserDetails";
                    //var url = window.location.origin + "/updateLoggedInUserDetails";
                    var jsonString = JSON.stringify({username: userId, personId: personId, persistentFaceId: persisted_face_id});

                    $.ajax({
                        type : 'POST',
                        url : url,
                        contentType: 'application/json',
                        data : jsonString,
                        success : function(data, status, xhr){
                            var h3 = document.createElement("H3");
                            var t3 = document.createTextNode("Your Face Registered As Below");
                            h3.appendChild(t3);
                            document.getElementById("face_report_data").appendChild(h3);

                            $("#face_report").show();

                            var row1 = document.createElement("tr");
                            var r1 = document.createTextNode("Name : " + fullName);
                            row1.appendChild(r1)
                            document.getElementById("face_report_data").appendChild(row1);

                            var row1 = document.createElement("tr");
                            var r1 = document.createTextNode("UserName : " + userId);
                            row1.appendChild(r1)
                            document.getElementById("face_report_data").appendChild(row1);

                            var row1 = document.createElement("tr");
                            var r1 = document.createTextNode("PersonId : " + personId);
                            row1.appendChild(r1)
                            document.getElementById("face_report_data").appendChild(row1);

                            var row1 = document.createElement("tr");
                            var r1 = document.createTextNode("Persistent Face Id : " + persisted_face_id);
                            row1.appendChild(r1)
                            document.getElementById("face_report_data").appendChild(row1);

                        },
                        error: function(xhr, status, error){
                            alert(error);
                            exit()
                        }
                    });
                }
            });
        }
    }

    function identify_faces(){
        document.getElementById('face_report_data').innerHTML ='';
        $("#face_report").show();
        var base64image = captured_uri;
        var userId = "anonymousUser";
        var personId = "null";
        var person_group_id = "users"
        var persisted_face_id = "null";
        var fullName = "";

        const json_string = {
            "image": base64image
        };
        var imgData = JSON.stringify(json_string);

        $.ajax({
            url: 'http://localhost:5000/face/detect',
            //url: window.location.origin + "/face/detect",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: imgData,
            type: 'POST',
            error: function(xhr, error){
                alert("Sorry some error Occurred");
                exit();
            },
            success: function(data) {
                var base64_response_image = data.response[0]['image'];
                var image = new Image();
                image.src = "data:image/png;base64," + base64_response_image;
                document.getElementById('results').innerHTML ='';
                document.getElementById("results").appendChild(image);
                for ( var i = 0; i < data.response.length; i++) {
                    var faceId = data.response[i]['faceId'];
                    const json_faceId = {
                        "faceId": faceId
                    };
                    $.ajax({
                        url: 'http://localhost:5000/face/person/identify',
                        //url: window.location.origin + "/face/person/identify",
                        dataType: 'json',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(json_faceId),
                        type: 'POST',
                        error: function(xhr, error){
                            alert("Sorry some error Occurred");
                        },
                        success: function(response) {
                            userId = response['userId'];
                            if (userId == "NotFound"){
                                var h3 = document.createElement("H3");
                                var t3 = document.createTextNode("User Details Not found ");
                                h3.appendChild(t3);
                                document.getElementById("face_report_data").appendChild(h3);
                            }
                            else{
                                $.ajax({
                                    url: 'http://localhost:8080/getUserDetails',
                                    //url: window.location.origin + "/getUserDetails",
                                    dataType: 'json',
                                    async: false,
                                    data: JSON.stringify({username : userId}),
                                    contentType: "application/json; charset=utf-8",
                                    type: 'POST',
                                    error: function(xhr, error){
                                        alert("Sorry some error Occurred");
                                        exit();
                                    },
                                    success: function(data) {
                                        personId = data.personId;
                                        fullName = data.fullName;
                                        persisted_face_id = data.persistentFaceId
                                    }
                                });
                                var h3 = document.createElement("H3");
                                var t3 = document.createTextNode("Identified User Details");
                                h3.appendChild(t3);
                                document.getElementById("face_report_data").appendChild(h3);

                                var row1 = document.createElement("tr");
                                var r1 = document.createTextNode("Full Name : " + fullName);
                                row1.appendChild(r1)
                                document.getElementById("face_report_data").appendChild(row1);

                                var row1 = document.createElement("tr");
                                var r1 = document.createTextNode("username : " + userId);
                                row1.appendChild(r1)
                                document.getElementById("face_report_data").appendChild(row1);

                                var row1 = document.createElement("tr");
                                var r1 = document.createTextNode("PersonId : " + personId);
                                row1.appendChild(r1)
                                document.getElementById("face_report_data").appendChild(row1);

                                var row1 = document.createElement("tr");
                                var r1 = document.createTextNode("Persistent Face Id : " + persisted_face_id);
                                row1.appendChild(r1)
                                document.getElementById("face_report_data").appendChild(row1);

                            }
                        }
                    });
                }
            }
        });
    }
</script>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</html>
