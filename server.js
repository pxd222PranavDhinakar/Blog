const express = require('express');
const path = require('path');
const app = express();

const PORT = process.env.PORT || 3000;

// Serve static files from the frontend directory
app.use(express.static(path.join(__dirname, 'frontend')));

// Define routes for each HTML page
app.get('/', (req, res) => {
  res.sendFile(path.resolve(__dirname, 'frontend', 'index.html'));
});

app.get('/project1', (req, res) => {
  res.sendFile(path.resolve(__dirname, 'frontend', 'project1.html'));
});

app.get('/project2', (req, res) => {
  res.sendFile(path.resolve(__dirname, 'frontend', 'project2.html'));
});

// Additional static pages can be defined here in the same way

// Catch-all route to handle any other requests (404 Not Found)
app.get('*', (req, res) => {
  res.status(404).send('404 Not Found');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
