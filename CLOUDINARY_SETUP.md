# Cloudinary Image Upload Setup Guide

This app uses Cloudinary for free image hosting. It's much easier to set up than Imgur - you just need a Cloud Name and Upload Preset!

## Why Cloudinary?

- ✅ **Easy Setup**: Just Cloud Name + Upload Preset (no complex API keys)
- ✅ **Free Tier**: 25 GB storage, 25 GB bandwidth/month
- ✅ **Fast CDN**: Images delivered via global CDN
- ✅ **Automatic Optimization**: Images are automatically optimized
- ✅ **Free Forever**: No credit card required for free tier

## Quick Setup (5 minutes)

### Step 1: Create Free Cloudinary Account

1. Go to [https://cloudinary.com/users/register_free](https://cloudinary.com/users/register_free)
2. Sign up with your email (no credit card needed)
3. Verify your email
4. You'll be redirected to the dashboard

### Step 2: Get Your Cloud Name

On the dashboard, you'll see:
```
Cloud name: dxyz123abc
```
**Copy this Cloud Name** - you'll need it in Step 4.

### Step 3: Create an Upload Preset

1. In the Cloudinary dashboard, click **Settings** (gear icon in top right)
2. Click on the **Upload** tab on the left
3. Scroll down to **Upload presets**
4. Click **Add upload preset**
5. Configure the preset:
   - **Preset name**: `campus_connect_posts` (or any name you like)
   - **Signing mode**: Select **Unsigned**
   - **Folder**: Leave empty or set to `campus_connect/posts`
   - Leave other settings as default
6. Click **Save**

**Copy the Preset Name** - you'll need it in Step 4.

### Step 4: Configure the App

Open `lib/services/image_upload_service.dart` and replace these lines:

```dart
static const String _cloudName = 'YOUR_CLOUD_NAME';  // Replace with your cloud name
static const String _uploadPreset = 'YOUR_UPLOAD_PRESET';  // Replace with your preset name
```

**Example:**
```dart
static const String _cloudName = 'dxyz123abc';
static const String _uploadPreset = 'campus_connect_posts';
```

### Step 5: Test It!

1. Run the app
2. Create a new post
3. Tap the image icon
4. Select an image
5. Submit the post
6. Image should upload to Cloudinary and display in the feed!

## How It Works

1. User picks image from gallery/camera
2. Image is compressed to 1920x1920, 85% quality
3. Multipart upload to Cloudinary with your upload preset
4. Cloudinary returns permanent HTTPS URL
5. URL saved in Firestore with the post
6. Images displayed using CachedNetworkImage

## Cloudinary Free Tier Limits

- **Storage**: 25 GB
- **Bandwidth**: 25 GB/month
- **Transformations**: 25 credits/month
- **Image/Video requests**: Unlimited
- **Upload API calls**: Unlimited

This is **more than enough** for a campus app!

## Managing Uploaded Images

### View Your Images

1. Go to [Cloudinary Dashboard](https://cloudinary.com/console)
2. Click **Media Library** on the left
3. You'll see all uploaded images organized by folder

### Delete Images

1. In Media Library, find the image
2. Click on it
3. Click the **Delete** button
4. Confirm deletion

### Monitor Usage

1. Go to Dashboard
2. See storage and bandwidth usage at the top
3. You'll get email alerts if you approach limits

## Troubleshooting

### Upload Fails with "Invalid Upload Preset"
- Make sure you created the upload preset as **Unsigned**
- Double-check the preset name matches exactly
- Preset names are case-sensitive

### Upload Fails with "Invalid Cloud Name"
- Verify cloud name from dashboard (Settings → Account)
- No spaces or special characters

### Images Not Displaying
- Check that imageUrl starts with `https://res.cloudinary.com/`
- Verify URL is saved correctly in Firestore
- Check internet connection

### "Please configure Cloudinary credentials" Error
- You haven't replaced `YOUR_CLOUD_NAME` and `YOUR_UPLOAD_PRESET`
- Open `lib/services/image_upload_service.dart` and update them

## Advanced: Signed Uploads (Optional)

For production apps with higher security needs:

1. Use **Signed** upload presets instead of Unsigned
2. Add API Key and API Secret to your backend
3. Generate signatures on your server
4. Include signature in upload request

For a campus app, unsigned uploads are perfectly fine!

## Cost Comparison

| Service | Free Tier | Good For |
|---------|-----------|----------|
| **Cloudinary** | 25 GB storage, 25 GB bandwidth | ✅ Small to medium apps |
| Imgur | Unlimited storage, 1,250 uploads/day | ✅ Simple personal projects |
| Firebase Storage | 5 GB storage, 1 GB/day bandwidth | ⚠️ Very small apps only |

**Verdict**: Cloudinary is the best balance of features and ease of setup!

## Example URLs

After upload, your images will have URLs like:
```
https://res.cloudinary.com/dxyz123abc/image/upload/v1699123456/campus_connect/posts/user123_1699123456.jpg
```

These URLs are:
- ✅ Permanent (never expire)
- ✅ Fast (global CDN)
- ✅ Secure (HTTPS)
- ✅ Optimized (automatic compression)

## Need Help?

- Cloudinary Documentation: [https://cloudinary.com/documentation](https://cloudinary.com/documentation)
- Upload API Guide: [https://cloudinary.com/documentation/upload_images](https://cloudinary.com/documentation/upload_images)
- Support: [https://support.cloudinary.com](https://support.cloudinary.com)

Enjoy unlimited image uploads! 🚀
