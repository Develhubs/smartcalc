#!/bin/bash

# Hostinger-specific export script with options for frontend-only or full-stack deployment

# Display menu for type of deployment
echo "=== Calculator Website Export Tool for Hostinger ==="
echo "Please select deployment type:"
echo "1) Static (Frontend-only) - For basic Hostinger hosting plans"
echo "2) Full-stack (Frontend + Backend) - For Hostinger plans with Node.js support"
read -p "Enter your choice (1 or 2): " deployment_choice

# Create a build directory if it doesn't exist
mkdir -p build

if [ "$deployment_choice" = "1" ]; then
    echo "=== Creating Static Frontend-Only Build ==="
    
    # Build just the frontend (Vite build)
    echo "Building frontend..."
    npx vite build
    
    # Create a temporary directory for the export
    mkdir -p export-temp-static
    
    # Copy only the frontend build files
    echo "Preparing static files for Hostinger..."
    cp -r dist/public/* export-temp-static/
    
    # Create .htaccess file for SPA routing on Apache
    echo "Creating .htaccess for SPA routing..."
    cat > export-temp-static/.htaccess << EOL
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /index.html [L]
</IfModule>
EOL
    
    # Create zip file
    echo "Creating zip file for static deployment..."
    cd export-temp-static
    zip -r ../build/calculator-static-for-hostinger.zip .
    cd ..
    
    # Clean up
    echo "Cleaning up..."
    rm -rf export-temp-static
    
    echo "=== Static Export Complete! ==="
    echo "Upload 'build/calculator-static-for-hostinger.zip' to your Hostinger public_html directory"
    echo "For detailed instructions, see HOSTINGER_DEPLOYMENT.md"
    
elif [ "$deployment_choice" = "2" ]; then
    echo "=== Creating Full-Stack Build ==="
    
    # Build the project (both frontend and backend)
    echo "Building project..."
    npm run build
    
    # Create a temporary directory for the export
    mkdir -p export-temp-fullstack
    
    # Copy necessary files to the export directory
    echo "Copying files to export directory..."
    cp -r dist export-temp-fullstack/
    cp package.json export-temp-fullstack/
    cp package-lock.json export-temp-fullstack/
    
    # Create a basic .env file template
    echo "Creating .env template..."
    cat > export-temp-fullstack/.env.example << EOL
NODE_ENV=production
PORT=3000
# Add your database connection string if using a database
# DATABASE_URL=mysql://username:password@localhost:3306/database_name
# Add your API keys if using AI features
# ANTHROPIC_API_KEY=your_api_key_here
EOL
    
    # Create README with special instructions
    echo "Creating README with Hostinger instructions..."
    cat > export-temp-fullstack/HOSTINGER_README.txt << EOL
=== CALCULATOR APP DEPLOYMENT ON HOSTINGER ===

Follow these steps to deploy on Hostinger:

1. Upload and extract this zip file to your Hostinger account using FTP or File Manager
2. Connect to your server via SSH (if available on your Hostinger plan)
3. Navigate to the extracted directory
4. Run: npm install --production
5. Create a .env file based on the .env.example template
6. Configure your Node.js application in Hostinger's hPanel
   - Set the entry point to: dist/index.js
   - Set the Node.js version to the latest available

For detailed instructions, see the HOSTINGER_DEPLOYMENT.md file in the original project.
EOL
    
    # Create zip file
    echo "Creating zip file for full-stack deployment..."
    cd export-temp-fullstack
    zip -r ../build/calculator-fullstack-for-hostinger.zip .
    cd ..
    
    # Clean up
    echo "Cleaning up..."
    rm -rf export-temp-fullstack
    
    echo "=== Full-Stack Export Complete! ==="
    echo "Upload 'build/calculator-fullstack-for-hostinger.zip' to your Hostinger account"
    echo "For detailed instructions, see HOSTINGER_DEPLOYMENT.md"
    
else
    echo "Invalid choice. Please run the script again and select 1 or 2."
    exit 1
fi

echo ""
echo "=== Export Summary ==="
echo "Export files are in the build directory:"
ls -la build/
echo ""
echo "Next steps:"
echo "1. Download the appropriate zip file from the build directory"
echo "2. Upload to your Hostinger account following the instructions in HOSTINGER_DEPLOYMENT.md"