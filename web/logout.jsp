<%
    // Invalidate the current session
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <script>
        // Clear localStorage to empty the cart
        localStorage.clear();

        // Redirect to index.html after clearing
        window.location.href = "index.html";
    </script>
</head>
<body>
    Logging out...
</body>
</html>