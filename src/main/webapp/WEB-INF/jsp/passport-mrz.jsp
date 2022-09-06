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
                    <li ><a href="/passport-mrz">Face Match & MRZ<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-file"></span></a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>
<header>
    <style type="text/css">
        #dvPreview
        {
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
        }

        img{
            max-width:400px;
            max-height: 300px;
        }

    </style>
</header>
<body>
<div class="overlay"></div>
<div class="container">
    <div class="row">
        <div id="initial-browse-doc" class="col-md-6">
            <div id="uploaded-doc" class="center-block"></div>
            <br/>
            <input id="fileupload-initial" type=file class="btn btn-success" value="Upload Document">
        </div>
        <div id="doc_preview" class="col-md-6" style="display: none">
            <div id="dvPreview"></div>
            <br/>
            <input type=button class="btn-sm btn-info" value="Analyze Document" onClick="detect_face()">
            <input id="fileupload-after" type=file class="btn-success" value="Upload Document">
        </div>
        <table id="docTable" style="display: none" class="col-md-6">
        </table>

    </div>
</div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script language="javascript" type="text/javascript">

    var base64image_uploaded = '';

    $(function () {
        $("#fileupload-initial").change(function () {
            $("#dvPreview").html("");
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
            if (regex.test($(this).val().toLowerCase())) {
                if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {

                    $("#doc_preview").show();
                    $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                }
                else {
                    if (typeof (FileReader) != "undefined") {
                        $("#initial-browse-doc").hide();
                        $("#doc_preview").show();
                        $("#dvPreview").append("<img />");
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            base64image_uploaded = e.target.result;
                            $("#dvPreview img").attr("src", base64image_uploaded);
                        }
                        reader.readAsDataURL($(this)[0].files[0]);
                    } else {
                        alert("This browser does not support FileReader.");
                    }
                }
            } else {
                alert("Please upload a valid image file.");
            }

        });
    });

    $(function () {
        $("#fileupload-after").change(function () {
            $("#dvPreview").html("");
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
            if (regex.test($(this).val().toLowerCase())) {
                if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                    $("#doc_preview").show();
                    $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                }
                else {
                    if (typeof (FileReader) != "undefined") {
                        $("#doc_preview").show();
                        $("#dvPreview").append("<img />");
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            base64image_uploaded = e.target.result;
                            $("#dvPreview img").attr("src", base64image_uploaded);
                        }
                        reader.readAsDataURL($(this)[0].files[0]);
                    } else {
                        alert("This browser does not support FileReader.");
                    }
                }
            } else {
                alert("Please upload a valid image file.");
            }

        });
    });


    $(function () {
        $("#fileupload-after").change(function () {
            $("#dvPreview").html("");
            var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
            if (regex.test($(this).val().toLowerCase())) {
                if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {
                    $("#doc_preview").show();
                    $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                }
                else {
                    if (typeof (FileReader) != "undefined") {
                        $("#doc_preview").show();
                        $("#dvPreview").append("<img />");
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            base64image_uploaded = e.target.result;
                            console.log(base64image_uploaded);
                            $("#dvPreview img").attr("src", base64image_uploaded);
                        }
                        reader.readAsDataURL($(this)[0].files[0]);
                    } else {
                        alert("This browser does not support FileReader.");
                    }
                }
            } else {
                alert("Please upload a valid image file.");
            }

        });
    });

    function detect_face() {
        document.getElementById('docTable').innerHTML ='';
        $("#docTable").show();
        var base64image = base64image_uploaded;
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
                $("body").removeClass("loading");
                exit();
            },
            success: function(data){
                document.getElementById('docTable').innerHTML ='';
                for ( var i = 0; i < data.response.length; i++) {
                    var base64_response_face = data.response[i]['cropped_face'];
                    if (base64_response_face == "NotValidDoc"){
                        var h3 = document.createElement("H3");
                        var t3 = document.createTextNode("Not a valid document");
                        h3.appendChild(t3);
                        document.getElementById("docTable").appendChild(h3);
                    }
                    else if (data.response[i]['valid'] == "False"){
                        var h3 = document.createElement("H3");
                        var t3 = document.createTextNode("MRZ code is invalid");
                        h3.appendChild(t3);
                        document.getElementById("docTable").appendChild(h3);
                    }
                    else
                    {
                        $("#docTable").show();
                        var docTable = document.getElementById("docTable");
                        var row = docTable.insertRow(0);
                        var cell1 = row.insertCell(0);
                        cell1.innerHTML = "<h4><b><u>Document Details</b></u></h4>";

                        var row = docTable.insertRow(1);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Face</h4>";
                        var image = new Image();
                        image.src = "data:image/png;base64," + base64_response_face;
                        cell2.appendChild(image);

                        var row = docTable.insertRow(2);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>MRZ</h4>";
                        var image = new Image();
                        image.src = "data:image/png;base64," + data.response[i]['mrz_img'];
                        cell2.appendChild(image);


                        var row = docTable.insertRow(3);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>mrz_data</h4>";
                        var t3 = document.createTextNode(data.response[i]['mrz_data']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(4);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Document Type</h4>";
                        var t3 = document.createTextNode(data.response[i]['document_type']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(5);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Country</h4>";
                        var t3 = document.createTextNode(data.response[i]['country']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(6);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>First Name</h4>";
                        var t3 = document.createTextNode(data.response[i]['first_name']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(7);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Last Name</h4>";
                        var t3 = document.createTextNode(data.response[i]['last_name']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(8);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Document Number</h4>";
                        var t3 = document.createTextNode(data.response[i]['document_no']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(9);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Document Check Number</h4>";
                        var t3 = document.createTextNode(data.response[i]['document_check_number']);
                        cell2.appendChild(t3);


                        var row = docTable.insertRow(10);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Nationality</h4>";
                        var t3 = document.createTextNode(data.response[i]['nationality']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(11);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Date Of Birth</h4>";
                        var t3 = document.createTextNode(data.response[i]['date_of_birth']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(12);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Birth Check Number</h4>";
                        var t3 = document.createTextNode(data.response[i]['birth_check_number']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(13);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Gender</h4>";
                        var t3 = document.createTextNode(data.response[i]['gender']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(14);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Expiry Date</h4>";
                        var t3 = document.createTextNode(data.response[i]['date_of_expiry']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(15);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Expiry Check Number</h4>";
                        var t3 = document.createTextNode(data.response[i]['expiry_check_number']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(16);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>SecondRow Check Number</h4>";
                        var t3 = document.createTextNode(data.response[i]['second_row_check_number']);
                        cell2.appendChild(t3);

                        var row = docTable.insertRow(17);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<h4>Valid Document</h4>";
                        var t3 = document.createTextNode(data.response[i]['doc_mrz_validity']);
                        cell2.appendChild(t3);


                    }

                }
            }
        });
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
