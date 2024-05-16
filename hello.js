const http = require('http');
const { exec } = require('child_process');

// Create a server object
const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.write('duck duckieee');
  res.end();
});

// Set the port the server will listen to
const PORT = process.env.PORT || 3000;

// Start the server and listen on the specified port
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// Keep the Node.js process alive indefinitely
process.stdin.resume();

// Loop forever
setInterval(() => {
  
  // Function to check if pm2 is running
  const isPm2Running = () => {
    return new Promise((resolve, reject) => {
      exec('pm2 list', (error, stdout, stderr) => {
        if (error) {
          reject(error);
          return;
        }
        resolve(stdout.includes('online'));
      });
    });
  };
  
  // Start the server using pm2
  const startServerWithPm2 = () => {
    exec('pm2 start server.js', (error, stdout, stderr) => {
      if (error) {
        console.error(`Error starting server with pm2: ${error.message}`);
        return;
      }
      console.log(stdout);
    });
  };

  // Check if pm2 is running, if not start the server with pm2
  isPm2Running()
    .then((running) => {
      if (!running) {
        console.log('No pm2 process found, starting server with pm2...');
        startServerWithPm2();
      } else {
        console.log('pm2 process found, server already running.');
      }
    })
    .catch((error) => {
      console.error(`Error checking pm2 status: ${error.message}`);
    });

}, 10000); // Loop every 10 seconds
