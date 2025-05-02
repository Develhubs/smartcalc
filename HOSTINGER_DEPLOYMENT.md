# Calculator Website Deployment Guide for Hostinger

This guide provides step-by-step instructions for deploying the Calculator website on Hostinger web hosting.

## Prerequisites

- A Hostinger hosting account (Premium or Business plan recommended)
- Access to Hostinger's hPanel
- FTP client installed (like FileZilla) or use Hostinger's File Manager
- Your domain set up in Hostinger

## Option 1: Static Site Deployment (Frontend Only)

This option is best for simple deployments without backend API needs.

### Step 1: Build the Project Locally

1. On your local machine, in the project directory, run:
   ```bash
   npm install
   npm run build
   ```

2. The build will be generated in the `dist/public` directory

### Step 2: Upload to Hostinger

1. Log in to your Hostinger account and access the hPanel
2. Navigate to "Files" → "File Manager" or use FTP credentials with FileZilla
3. Go to the `public_html` directory
4. Upload all files from the `dist/public` directory to `public_html`

### Step 3: Configure for SPA Routing

1. Create a new file called `.htaccess` in your `public_html` directory
2. Add the following content:

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

3. Save the file

### Step 4: Test Your Website

1. Visit your domain in a browser to ensure everything is working properly
2. Test various calculators and navigation to ensure they work as expected

## Option 2: Full-Stack Deployment (Frontend + Backend)

This option is for when you need the backend API functionality.

### Step 1: Verify Your Hosting Plan

1. Ensure your Hostinger plan supports Node.js applications
2. Check if SSH access is available on your plan

### Step 2: Set Up MySQL Database (If Needed)

1. In hPanel, go to "Databases" → "MySQL Databases"
2. Create a new database and user
3. Note the database credentials for later use

### Step 3: Upload the Full Project

1. Package your project using the provided script:
   ```bash
   ./export-project.sh
   ```
2. Upload the created zip file (`build/calculator-website.zip`) to your Hostinger account using FTP
3. Extract the files to a directory of your choice (e.g., `calculator-app`)

### Step 4: Configure Node.js Application

1. Access SSH through Hostinger's hPanel
2. Navigate to your project directory:
   ```bash
   cd calculator-app
   ```
3. Install dependencies:
   ```bash
   npm install --production
   ```
4. Create a `.env` file:
   ```bash
   touch .env
   nano .env
   ```
5. Add necessary environment variables:
   ```
   NODE_ENV=production
   PORT=3000  # This will be overridden by Hostinger
   DATABASE_URL=mysql://username:password@localhost:3306/your_database
   ANTHROPIC_API_KEY=your_api_key_if_using_ai
   ```

### Step 5: Set Up Node.js Application in Hostinger

1. Go to "Website" → "Node.js" in hPanel
2. Create a new Node.js application
3. Configure the settings:
   - Entry point: `dist/index.js`
   - Node.js version: Select the latest available (v16+)
   - Application URL: Your domain or subdomain
4. Save and start the application

### Step 6: Configure Domain

1. Go to "Domains" → "Manage"
2. Point your domain or create a subdomain that points to your Node.js application

## Troubleshooting Hostinger Deployment

### Common Issues and Solutions

1. **"404 Page Not Found" errors**
   - Check if your .htaccess file is correctly set up
   - Ensure all files were uploaded correctly

2. **Node.js application not starting**
   - Check Hostinger's Node.js logs in hPanel
   - Verify your entry point is correct
   - Make sure all dependencies are installed

3. **Database connection issues**
   - Verify database credentials in your .env file
   - Ensure the database is created and accessible

4. **Performance issues**
   - Consider optimizing your application
   - Check resource usage in Hostinger's statistics

### Getting Help

If you encounter issues with your Hostinger deployment:

1. Check Hostinger's Knowledge Base: [https://support.hostinger.com](https://support.hostinger.com)
2. Contact Hostinger Support through hPanel
3. Refer to the Node.js documentation for server-specific issues

## Maintenance

1. **Updates**: To update your application:
   - Make changes locally
   - Rebuild using `npm run build`
   - Upload the new files following the same deployment process

2. **Monitoring**: Use Hostinger's built-in statistics to monitor your site's performance

3. **Backups**: Set up regular backups in Hostinger hPanel