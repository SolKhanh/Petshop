function navigateWithAuth(targetUrl) {
    const token = localStorage.getItem("jwtToken");
    if (!token) {
        window.location.href = "/login";
        return;
    }

    fetch(targetUrl, {
        method: "GET", // hoặc HEAD nếu server hỗ trợ
        headers: {
            "Authorization": "Bearer " + token
        }
    })
        .then(response => {
            if (response.ok) {
                window.location.href = targetUrl;
            } else {
                window.location.href = "/login";
            }
        })
        .catch(error => {
            console.error("Lỗi điều hướng có xác thực:", error);
            window.location.href = "/login";
        });
}
