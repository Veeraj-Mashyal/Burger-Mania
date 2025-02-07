<%-- 
    Document   : trackOrder
    Created on : 3 Feb 2025, 8:24:48 pm
    Author     : admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Track Your Order</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_GOOGLE_MAPS_API_KEY"></script>
    <script>
        let map, marker;
        
        function initMap() {
            map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: 20.5937, lng: 78.9629 }, // Default to India
                zoom: 12,
            });
            marker = new google.maps.Marker({ map });
            fetchLocation();
        }

        function fetchLocation() {
            const orderId = "<%= request.getParameter("orderId") %>";

            fetch("TrackOrderServlet?orderId=" + orderId)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    document.getElementById("status").innerText = data.error;
                } else {
                    const position = { lat: parseFloat(data.latitude), lng: parseFloat(data.longitude) };
                    map.setCenter(position);
                    marker.setPosition(position);
                    document.getElementById("status").innerText = "Status: " + data.status;
                }
                setTimeout(fetchLocation, 5000); // Refresh every 5 seconds
            })
            .catch(error => console.error("Error fetching location:", error));
        }
    </script>
</head>
<body onload="initMap()">
    <h2>Track Your Order</h2>
    <p id="status">Fetching location...</p>
    <div id="map" style="height: 400px; width: 100%;"></div>
</body>
</html>

