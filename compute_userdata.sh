#!/bin/bash
set -euo pipefail

# Update and install dependencies
yum update -y
yum install -y git nginx

# Install Node.js 20 (required by Vite 7+)
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
yum install -y nodejs

# Install MariaDB Server
dnf install -y mariadb105-server unzip || yum install -y mariadb-server unzip

systemctl enable --now mariadb

# Set variables
DBName="gastroman_db"
DBUser="gastroman_user"
DBPassword="password3141!"

# Initialize database and app user (idempotent)
mysql -uroot <<SQL
CREATE DATABASE IF NOT EXISTS \`${DBName}\`;
CREATE USER IF NOT EXISTS '${DBUser}'@'localhost' IDENTIFIED BY '${DBPassword}';
ALTER USER '${DBUser}'@'localhost' IDENTIFIED BY '${DBPassword}';
GRANT ALL PRIVILEGES ON \`${DBName}\`.* TO '${DBUser}'@'localhost';
FLUSH PRIVILEGES;
SQL

# Install pnpm
npm install -g pnpm

# Clone the repository
git clone https://github.com/tesar27/gastroman-frontend.git /var/www/app/frontend

# Build the React app
cd /var/www/app/frontend
pnpm install
pnpm run build

# Set ownership
chown -R ec2-user:ec2-user /var/www/app/frontend
su - ec2-user -c 'git config --global --add safe.directory /var/www/app/frontend'

# Configure Nginx to serve the React app
cat <<'EOT' > /etc/nginx/conf.d/react.conf
server {
    listen 80;
    server_name _;
    root /var/www/app/frontend/dist;
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
systemctl enable nginx
systemctl restart nginx

# Start the Express.js app only if present
if [ -d "/var/www/app/express-app" ]; then
    cd /var/www/app/express-app
    npm ci || npm install
    if npm run | grep -q " start"; then
        nohup npm start >/var/log/express-app.log 2>&1 &
    else
        echo "No start script found in express app; skipping startup."
    fi
else
    echo "Express app directory not found; skipping backend startup."
fi