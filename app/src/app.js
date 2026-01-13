const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 8080;

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.json({
    message: 'Hello from GitOps pipeline with ytt!',
    timestamp: new Date().toISOString(),
    version: process.env.APP_VERSION || '1.0.0',
    pod: process.env.HOSTNAME || 'unknown',
    node: os.hostname(),
    environment: process.env.ENVIRONMENT || 'development'
  });
});

app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

app.get('/config', (req, res) => {
  res.json({
    environment: process.env.ENVIRONMENT || 'development',
    debug: process.env.DEBUG || 'false',
    port: port,
    memory: process.memoryUsage()
  });
});

app.post('/echo', (req, res) => {
  res.json({
    received: req.body,
    timestamp: new Date().toISOString()
  });
});

// Start server
app.listen(port, () => {
  console.log(`🚀 Server running on port ${port}`);
  console.log(`📊 Environment: ${process.env.ENVIRONMENT || 'development'}`);
});
