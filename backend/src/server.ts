import express from 'express';

const app = express();
const port = process.env.PORT || 8080;

// Simple protected endpoint
app.get('/', (req, res) => {
  // IAP passes headers with user info
  const email = req.header('x-goog-authenticated-user-email');
  const user = email ? email.replace('accounts.google.com:', '') : 'anonymous';
  res.send(`Hello, ${user}! You are authenticated via IAP.`);
});

app.listen(port, () => {
  console.log(`Backend running on port ${port}`);
});
