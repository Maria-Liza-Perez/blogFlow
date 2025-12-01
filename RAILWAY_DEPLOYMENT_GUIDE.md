# BlogFlow Railway Deployment Guide

## Fixed Issues

### 1. Apache ServerName Warning
- Added \ServerName localhost\ to Apache configuration in Dockerfile
- This suppresses the warning: "Could not reliably determine the server's fully qualified domain name"

### 2. Improved Dockerfile
The updated Dockerfile now includes:
- Proper Apache configuration
- ServerName directive set to localhost
- Security headers (ServerTokens, ServerSignature)
- Correct permissions for uploads and runtime directories
- Proper Virtual Host configuration

### 3. Created Railway Configuration
- Added \ailway.json\ for Railway-specific settings
- Added \.dockerignore\ to exclude unnecessary files

## Deployment Steps

### Step 1: Update Environment Variables in Railway

In your Railway project, add these environment variables:

\\\
DB_HOST=ep-weathered-credit-a1gxa7kf-pooler.ap-southeast-1.aws.neon.tech
DB_PORT=5432
DB_DATABASE=neondb
DB_USERNAME=neondb_owner
DB_PASSWORD=npg_EjHX6zYCJZw4
PGSSLMODE=require
APP_URL=\
\\\

**Important:** Railway will automatically replace \\\ with your actual deployment URL.

### Step 2: Database Setup

1. Your Neon PostgreSQL database is already configured
2. Make sure to run the schema file if not already done:
   - Use the \logflow_postgres.sql\ file in the root directory
   - Run it in your Neon database console

### Step 3: Deploy to Railway

1. Push your updated code to your Git repository:
\\\ash
git add .
git commit -m "Fixed Apache configuration for Railway deployment"
git push origin main
\\\

2. Railway will automatically detect the changes and redeploy

### Step 4: Verify Deployment

After deployment completes:
1. Check the logs in Railway dashboard - the Apache warning should be gone
2. Visit your Railway URL
3. Test the login/register functionality
4. Verify database connections work

## Files Modified

1. **Dockerfile** - Added Apache ServerName configuration and proper virtual host setup
2. **railway.json** - Railway-specific configuration
3. **.dockerignore** - Excludes unnecessary files from Docker build
4. **app/config/config.php** - Updated to use APP_URL from environment variables

## Troubleshooting

### If you still see Apache warnings:
- Check Railway logs to ensure environment variables are set
- Verify the Dockerfile built successfully

### If base_url is not working:
- In Railway dashboard, set APP_URL to your full Railway domain (e.g., https://blogflow-production.up.railway.app)
- Redeploy

### If database connection fails:
- Verify all DB_* environment variables are set correctly in Railway
- Check that PGSSLMODE=require is set
- Ensure your Neon database is active

## Next Steps

After successful deployment:
1. Test all features (auth, posts, comments, likes, notifications)
2. Check file uploads work correctly
3. Monitor logs for any PHP errors
4. Consider setting ENVIRONMENT to 'production' in config.php after testing

## Support

If you encounter issues:
1. Check Railway deployment logs
2. Review Apache error logs in Railway
3. Verify all environment variables are properly set