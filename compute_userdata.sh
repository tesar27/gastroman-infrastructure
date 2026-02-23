#!/bin/bash
# Update and install dependencies
yum update -y
yum install -y git nginx nodejs npm

# Clone the repository
git clone https://github.com/tesar27/gastroman-frontend.git /var/www/app/frontend

# Build the React app
cd /var/www/app/frontend
npm install
npm run build

# Configure Nginx to serve the React app
cat <<EOT > /etc/nginx/conf.d/react.conf
server {
    listen 80;
    server_name _;
    root /var/www/app/frontend/build;
    index index.html;
    location / {
        try_files $uri /index.html;
    }
    location /api/ {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOT
systemctl restart nginx

# Start the Express.js app
cd /var/www/app/express-app
npm install
npm start