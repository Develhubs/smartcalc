# Deployment Guide for Calculator Website

This guide will help you deploy the Calculator website to your own web hosting server. There are two deployment options: static (frontend-only) or full-stack (including backend features).

## Prerequisites

- Node.js v16 or higher
- NPM or Yarn
- Web hosting service that supports Node.js apps (for full-stack deployment) OR any static web hosting (for frontend-only)
- Git (optional but recommended)

## Option 1: Static Deployment (Frontend-Only)

This option is simpler and works if you don't need the backend API functionality (like the AI suggestion features). It will work with any static hosting service like Netlify, Vercel, GitHub Pages, or traditional web hosting.

### Step 1: Build the Static Version

1. Clone or download the project to your local machine
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   npm install
   ```
4. Create a production build:
   ```bash
   npm run build
   ```
5. The built files will be in the `dist/public` directory

### Step 2: Upload to Your Hosting

Upload the contents of the `dist/public` directory to your web hosting service:

- **Traditional hosting**: Upload files via FTP to your web root directory
- **Netlify/Vercel**: Connect your repository or drag and drop the `dist/public` folder
- **GitHub Pages**: Push the `dist/public` contents to your gh-pages branch

### Step 3: Configure Your Server (If Needed)

If you're using Apache, create a `.htaccess` file in your web root with:

```
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>
```

For Nginx, add this to your server block:

```
location / {
  try_files $uri $uri/ /index.html;
}
```

## Option 2: Full-Stack Deployment

This option is for when you want to include both the frontend and backend functionality.

### Step 1: Prepare the Project

1. Clone or download the project to your local machine
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   npm install
   ```

### Step 2: Configure Database (Optional)

If you're using database features:

1. Set up a PostgreSQL database on your server or use a cloud service like Neon
2. Update your environment variables to include your database connection string:
   ```
   DATABASE_URL=postgres://username:password@hostname:port/database
   ```

### Step 3: Set Environment Variables

Create a `.env` file in your project root with:

```
NODE_ENV=production
PORT=3000  # Or your preferred port
DATABASE_URL=your_database_url_if_using_database
ANTHROPIC_API_KEY=your_anthropic_api_key_if_using_ai_features
```

### Step 4: Build the Application

Build both frontend and backend:

```bash
npm run build
```

This creates a `dist` directory with both frontend and backend code.

### Step 5: Deploy to Your Server

1. Transfer the following to your server:
   - `dist` directory
   - `package.json`
   - `.env` file
   - `node_modules` directory (or run `npm install --production` on the server)

2. On your server, start the application:
   ```bash
   cd /path/to/your/app
   NODE_ENV=production node dist/index.js
   ```

### Step 6: Set Up Process Manager

For production, use a process manager like PM2:

1. Install PM2:
   ```bash
   npm install -g pm2
   ```

2. Start your application:
   ```bash
   pm2 start dist/index.js --name calculator-app
   ```

3. Configure PM2 to start on boot:
   ```bash
   pm2 startup
   pm2 save
   ```

### Step 7: Set Up Reverse Proxy (Recommended)

For production deployments, use Nginx as a reverse proxy:

```
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Then secure it with SSL using Let's Encrypt.

## Troubleshooting

### Common Issues

1. **Page not found errors**: Ensure your server is configured to handle client-side routing
2. **API errors**: Check your server logs and ensure your environment variables are properly set
3. **Database connection issues**: Verify your database credentials and connection string
4. **Permission issues**: Make sure your web server has appropriate permissions to access the files

### Logs

If you encounter issues, check your server logs:

```bash
pm2 logs calculator-app
```

## Maintenance

1. **Updates**: To update your application, rebuild and redeploy following the steps above
2. **Monitoring**: Use PM2's monitoring features to keep track of your application:
   ```bash
   pm2 monit
   ```

## Security Considerations

1. Always use HTTPS in production
2. Keep your Node.js and npm packages updated
3. Store sensitive information in environment variables, not in your code
4. Consider using a Web Application Firewall (WAF) for additional protection

## Need Help?

If you need further assistance with deployment, consider:

1. Consulting the documentation for your specific hosting provider
2. Seeking help from web hosting support
3. Exploring managed hosting options that simplify deployment