$( document ).ready(function() {
    var url = window.location.origin;

    // GET REQUEST
    $("#searchButton").click(function(event){
        event.preventDefault();
        $("#search-table").show();
        $("#createProfileForm").hide();
        $("#result").html("");
        ajaxGet();
    });


    // DO GET
    function ajaxGet(){
        var passportNumber = $("#passportNumber").val().toLowerCase();
        var apiurl = url + "/profile/getProfile/" + passportNumber;
        $.getJSON(apiurl, function (data) {


            const table = new Tabulator("#search-table", {
                data: data,
                layout: "fitColumns",
                columns: [{
                    title: "Name",
                    field: "name",
                    width: 150
                }, {
                    title: "PassPort Number",
                    field: "passportNumber",
                    align: "left",
                }, {
                        title: "Country",
                        field: "country",
                        align: "left",
                }, {
                        title: "PassPort Type",
                        field: "passportType",
                        align: "left",
                }, {
                        title: "isPreclearanceDone",
                        field: "preclearanceDone",
                        align: "left",
                }, {
                        title: "isBlacklisted",
                        field: "blacklisted",
                        align: "left",
                },],
            });

        });

    }
})

$( document ).ready(function() {
    var url = window.location.origin;

    // GET REQUEST
    $("#allProfileButton").click(function(event){
        event.preventDefault();
        $("#search-table").show();
        $("#createProfileForm").hide();
        $("#result").html("");
        ajaxGet();
    });


    // DO GET
    function ajaxGet(){
        var apiurl = url + "/profile/getAllProfiles";
        $.getJSON(apiurl, function (data) {


            const table = new Tabulator("#search-table", {
                data: data,
                layout: "fitColumns",
                columns: [{
                    title: "Name",
                    field: "name",
                    width: 150
                }, {
                    title: "PassPort Number",
                    field: "passportNumber",
                    align: "left",
                }, {
                    title: "Country",
                    field: "country",
                    align: "left",
                }, {
                    title: "PassPort Type",
                    field: "passportType",
                    align: "left",
                }, {
                    title: "isPreclearanceDone",
                    field: "preclearanceDone",
                    align: "left",
                }, {
                    title: "isBlacklisted",
                    field: "blacklisted",
                    align: "left",
                },],
            });

        });

    }
})

$(document).ready(function() {
    $("#createProfileButton").click(function() {
        $("#createProfileForm").toggle();
        document.getElementById("createProfileForm").reset();
        $("#search-table").hide();
        $("#result").html("");

    });
});


$(document).ready(function() {
    $("#createProfileForm").submit(function(event){
        event.preventDefault();
        var form = $(this);
        var profileName = form.find('input[name="name"]').val();
        var passportNumber = form.find('input[name="passportNumber"]').val().toLowerCase();
        var passportType = form.find('input[name="passportType"]').val();
        var Country = form.find('input[name="Country"]').val();
        var isBlacklisted = false;
        let isPreclearanceDone = false;

        var url = window.location.origin + "/profile/saveProfile";
        var jsonString = JSON.stringify({name: profileName, passportNumber: passportNumber, country: Country, blacklisted: isBlacklisted, preclearanceDone: isPreclearanceDone,passportType: passportType});
        $.ajax({
            type : 'POST',
            url : url,
            contentType: 'application/json',
            data : jsonString,
            success : function(data, status, xhr){
                $("#createProfileForm").toggle();
                $("#result").html("<h3>Profile Created</h3>");
            },
            error: function(xhr, status, error){
                alert(error);
            }
        });
    });
});
