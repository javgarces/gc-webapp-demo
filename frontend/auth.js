const allowedEmails = ["your_email@gmail.com"]; // Whitelist

function onLoginSuccess(response) {
  const credential = response.credential;
  const payload = parseJwt(credential);
  if (!allowedEmails.includes(payload.email)) {
    alert("Access denied");
    return;
  }

  document.getElementById('login-container').style.display = 'none';
  document.getElementById('app').style.display = 'block';

  // Example backend call with API key
  fetch('https://YOUR_BACKEND_URL/hello', {
    headers: {
      'x-api-key': 'YOUR_FRONTEND_API_KEY'
    }
  })
    .then(r => r.text())
    .then(console.log)
    .catch(console.error);
}

function parseJwt(token) {
  const base64Url = token.split('.')[1];
  const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
  const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
    return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
  }).join(''));
  return JSON.parse(jsonPayload);
}
