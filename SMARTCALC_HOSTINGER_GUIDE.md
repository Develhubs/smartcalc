# SmartCalc Deployment Guide for Hostinger

This guide will help you export the SmartCalc code and deploy it on your Hostinger web hosting server.

## Step 1: Export the Code from Replit

1. Click on the three dots (...) in the Replit file browser
2. Select "Download as zip"
3. Save the file to your computer
4. Rename the downloaded file to "SmartCalc.zip" if needed

## Step 2: Prepare the Project Locally

1. Extract the "SmartCalc.zip" file to a folder on your computer
2. Open a terminal/command prompt and navigate to the extracted folder
3. Install dependencies:
   ```bash
   npm install
   ```
4. Build the project:
   ```bash
   npm run build
   ```
5. This will create a `dist` directory with the built files

## Step 3: Deploy to Hostinger

Hostinger offers two main deployment options:

### Option A: Static Deployment (Frontend Only)

This is the simpler option and works for basic Hostinger shared hosting plans:

1. Log in to your Hostinger control panel
2. Navigate to File Manager or use FTP to connect to your server
3. Go to the `public_html` directory
4. Upload the contents of the `dist/public` directory from your local build
5. Create a new file named `.htaccess` in your `public_html` directory with this content:

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

6. Your website should now be accessible at your domain

### Option B: Full-Stack Deployment (Backend + Frontend)

Use this option if you need the backend API functionality (like AI suggestions) and have a Hostinger plan with Node.js support:

1. Log in to your Hostinger control panel
2. Navigate to the File Manager or use FTP
3. Create a directory for your application (e.g., `smartcalc`)
4. Upload the following to this directory:
   - The entire `dist` directory from your local build
   - `package.json` and `package-lock.json` files
   - Create a `.env` file with any required environment variables

5. If your Hostinger plan supports SSH:
   - Connect to your server via SSH
   - Navigate to your application directory
   - Run `npm install --production`

6. In the Hostinger control panel:
   - Navigate to the Node.js section
   - Create a new Node.js application
   - Set the entry point to `dist/index.js`
   - Choose the latest available Node.js version
   - Configure your domain to point to this application

## Step 4: Verify Your Deployment

1. Visit your website URL to make sure everything is working correctly
2. Test different calculators to ensure they function properly
3. Verify that page routing works correctly

## Troubleshooting

### Common Issues:

1. **404 Errors**: 
   - Ensure your `.htaccess` file is correctly set up for static deployments
   - Check that the file was uploaded with the right content

2. **Missing Calculator Features**:
   - Make sure all JavaScript files were uploaded correctly
   - Check the browser console for any errors

3. **Node.js Application Not Starting**:
   - Check Hostinger logs for specific error messages
   - Verify your entry point path is correct
   - Ensure all dependencies were installed

4. **White Screen or Blank Page**:
   - Check if all required files were uploaded
   - Verify that the HTML, CSS, and JavaScript files are in the correct locations

### Getting Help:

If you encounter issues specific to Hostinger hosting:

1. Check Hostinger's knowledge base: [https://support.hostinger.com](https://support.hostinger.com)
2. Contact Hostinger support through your control panel
3. Provide details about your deployment method and any specific error messages

## Maintenance

After deployment, to update your website:

1. Make changes to your code locally
2. Rebuild the project with `npm run build`
3. Upload the new files following the same deployment process
4. For the static version, you only need to update the files in `dist/public`
5. For the full-stack version, you'll need to update the entire `dist` directory