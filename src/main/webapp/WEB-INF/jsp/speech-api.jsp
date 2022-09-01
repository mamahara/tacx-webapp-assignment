<!DOCTYPE html>
<html>
<head>
    <title>Place Autocomplete Address Form</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCYxX7bKKdQz6D2EbM4K5Jj5rIvNJzDx5c&callback=initAutocomplete&libraries=places&v=weekly"
            defer
    ></script>

    <style type="text/css">
        /* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
        #map {
            height: 100%;
        }

        /* Optional: Makes the sample page fill the window. */
        html,
        body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #locationField,
        #controls {
            position: relative;
            width: 480px;
        }
        #locationField1,
        #controls {
            position: relative;
            width: 480px;
        }
        #locationField2,
        #controls {
            position: relative;
            width: 480px;
        }
        #locationField3,
        #controls {
            position: relative;
            width: 480px;
        }

        #autocomplete {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 99%;
        }

        #autocomplete1 {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 99%;
        }


        #autocomplete2 {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 99%;
        }


        #autocomplete3 {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 99%;
        }
        .label {
            text-align: right;
            font-weight: bold;
            width: 100px;
            color: #303030;
            font-family: "Roboto", Arial, Helvetica, sans-serif;
        }

        #address {
            border: 1px solid #000090;
            background-color: #f0f9ff;
            width: 480px;
            padding-right: 2px;
        }

        #address td {
            font-size: 10pt;
        }

        .field {
            width: 99%;
        }

        .slimField {
            width: 80px;
        }

        .wideField {
            width: 200px;
        }

        #locationField {
            height: 20px;
            margin-bottom: 2px;
        }
        #locationField1 {
            height: 20px;
            margin-bottom: 2px;
        }


        #locationField2 {
            height: 20px;
            margin-bottom: 2px;
        }


        #locationField3 {
            height: 20px;
            margin-bottom: 2px;
        }

    </style>
    <script>
        let placeSearch;
        let autocomplete;
        let autocomplete1;
        const componentForm = {
            street_number: "short_name",
            route: "long_name",
            locality: "long_name",
            administrative_area_level_1: "short_name",
            country: "long_name",
            postal_code: "short_name",
        };

        function initAutocomplete() {
            autocomplete = new google.maps.places.Autocomplete(
                document.getElementById("autocomplete"),
                {
                    types: ["geocode"],
                }
            );
            autocomplete.setFields(["address_component"]);
            autocomplete.addListener("place_changed", fillInAddress);


            autocomplete1 = new google.maps.places.Autocomplete(
                document.getElementById("autocomplete1"),
                {
                    types: ["geocode"],
                    strictBounds: true,

                }
            );
            autocomplete1.setFields(["address_component"]);
            autocomplete1.addListener("place_changed", fillInAddress);


            autocomplete2 = new google.maps.places.Autocomplete(
                document.getElementById("autocomplete2"),
                {
                    types: ["geocode"],
                    strictBounds: true,
                }
            );
            autocomplete2.setFields(["address_component"]);
            autocomplete2.addListener("place_changed", fillInAddress);


            autocomplete3 = new google.maps.places.Autocomplete(
                document.getElementById("autocomplete3"),
                {
                    types: ["geocode"],
                    componentRestrictions: {
                        country: 'AE'
                    },

                }
            );
            autocomplete3.setFields(["address_component"]);
            autocomplete3.addListener("place_changed", fillInAddress);
        }

        function fillInAddress() {
            // Get the place details from the autocomplete object.
            var place = this.getPlace();

            for (const component in componentForm) {
                document.getElementById(component).value = "";
                document.getElementById(component).disabled = false;
            } // Get each component of the address from the place details,
            // and then fill-in the corresponding field on the form.

            for (const component of place.address_components) {
                const addressType = component.types[0];

                if (componentForm[addressType]) {
                    const val = component[componentForm[addressType]];
                    document.getElementById(addressType).value = val;
                }
            }
        } // Bias the autocomplete object to the user's geographical location,
        // as supplied by the browser's 'navigator.geolocation' object.

        function geolocate() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition((position) => {
                    const geolocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                    };
                    const circle = new google.maps.Circle({
                        center: geolocation,
                        radius: 5000,
                    });
                    autocomplete.setBounds(circle.getBounds());
                    autocomplete1.setBounds(circle.getBounds());

                    var dubaiBounds = {
                        north: 25.3585607,
                        east: 55.5650393,
                        south: 24.7921359,
                        west: 54.8904543
                    };
                    autocomplete2.setBounds(dubaiBounds);
                    autocomplete3.setBounds(circle.getBounds());
                });
            }
        }
    </script>
</head>
<body>

<p><b>Location biasing</b></p>
<p>Bias results to a specified circle by passing a location and a radius parameter.</p>
<p>Results outside of the defined area may still be displayed.</p>
<div id="locationField">
    <input
            id="autocomplete"
            placeholder="Enter your address"
            onFocus="geolocate()"
            type="text"
    />
</div>

<p><b>Location restrict</b></p>
<p>Restrict results to the region defined by location and a radius parameter, by adding the strictbounds parameter..</p>
<p>Autocomplete service to prefer showing results within that circle. radius or defaultBounds</p>
<p>This shows only within 5 km</p>

<div id="locationField1">
    <input
            id="autocomplete1"
            placeholder="Enter your address"
            onFocus="geolocate()"
            type="text"
    />
</div>


<p><b>Specific to a user defined Geographical region : Dubai</b></p>

<div id="locationField2">
    <input
            id="autocomplete2"
            placeholder="Enter your address"
            onFocus="geolocate()"
            type="text"
    />
</div>


<p><b>Specific to a country: UAE</b></p>
<p><b>components</b> parameter to filter results to show only those places within a specified country.</p>

<div id="locationField3">
    <input
            id="autocomplete3"
            placeholder="Enter your address"
            onFocus="geolocate()"
            type="text"
    />
</div>

<table id="address">
    <tr>
        <td class="label">Street address</td>
        <td class="slimField">
            <input class="field" id="street_number" disabled="true" />
        </td>
        <td class="wideField" colspan="2">
            <input class="field" id="route" disabled="true" />
        </td>
    </tr>
    <tr>
        <td class="label">City</td>
        <td class="wideField" colspan="3">
            <input class="field" id="locality" disabled="true" />
        </td>
    </tr>
    <tr>
        <td class="label">State</td>
        <td class="slimField">
            <input
                    class="field"
                    id="administrative_area_level_1"
                    disabled="true"
            />
        </td>
        <td class="label">Zip code</td>
        <td class="wideField">
            <input class="field" id="postal_code" disabled="true" />
        </td>
    </tr>
    <tr>
        <td class="label">Country</td>
        <td class="wideField" colspan="3">
            <input class="field" id="country" disabled="true" />
        </td>
    </tr>
</table>


</body>
</html>