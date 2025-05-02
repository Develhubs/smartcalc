#!/bin/bash

# Create a build directory if it doesn't exist
mkdir -p build

# Build the project
echo "Building project..."
npm run build

# Create a temporary directory for the export
mkdir -p export-temp

# Copy necessary files to the export directory
echo "Copying files to export directory..."
cp -r dist export-temp/
cp package.json export-temp/
cp package-lock.json export-temp/
cp README.md export-temp/
cp DEPLOYMENT_GUIDE.md export-temp/
cp -r client export-temp/
cp -r server export-temp/
cp -r db export-temp/
cp -r shared export-temp/
cp drizzle.config.ts export-temp/
cp vite.config.ts export-temp/
cp tailwind.config.ts export-temp/
cp tsconfig.json export-temp/
cp postcss.config.js export-temp/
cp components.json export-temp/

# Create zip file
echo "Creating zip file..."
cd export-temp
zip -r ../build/calculator-website.zip .
cd ..

# Create tar.gz file (alternative to zip)
echo "Creating tar.gz file..."
cd export-temp
tar -czf ../build/calculator-website.tar.gz .
cd ..

# Clean up
echo "Cleaning up..."
rm -rf export-temp

echo "Export complete! Files are in the build directory:"
echo " - build/calculator-website.zip"
echo " - build/calculator-website.tar.gz"
echo ""
echo "Upload either of these files to your web hosting server and follow the instructions in DEPLOYMENT_GUIDE.md"