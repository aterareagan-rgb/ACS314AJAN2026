# Backend Setup Guide

## Quick Start

### Option 1: Using PHP Built-in Server (Recommended for Development)

1. **Open PowerShell** and navigate to the backend folder:
```powershell
cd c:\ACS314AJAN2026PROJECTT\backend
```

2. **Start PHP server**:
```powershell
php -S localhost:8000
```

3. **Access the API** at: `http://localhost:8000/flutter_api/`

### Option 2: Using XAMPP/WAMP

1. Copy the `backend/flutter_api` folder to `C:\xampp\htdocs\`
2. Start Apache in XAMPP
3. API will be available at: `http://localhost/flutter_api/`

## Test Credentials

**Email:** john@example.com  
**Password:** password123

**Email:** jane@example.com  
**Password:** password123

## API Endpoints

### Login
- **URL:** `POST /flutter_api/login.php`
- **Body:** `email=user@example.com&password=password123`
- **Response:** User data on success

### Signup
- **URL:** `POST /flutter_api/signup.php`
- **Body:** `firstname=John&lastname=Doe&email=john@example.com&phone=1234567890&password=password123&confirmPassword=password123`
- **Response:** New user data on success

## Important Notes

- For Android Emulator: Replace `http://localhost:8000` with `http://10.0.2.2:8000` in Flutter code
- For Physical Device: Replace with your PC's IP address (e.g., `http://192.168.x.x:8000`)
- Users are stored in `users.json`

## Files Structure

```
backend/
├── flutter_api/
│   ├── config.php       (Configuration & helpers)
│   ├── login.php        (Login endpoint)
│   ├── signup.php       (Registration endpoint)
│   └── users.json       (User storage)
```

## Troubleshooting

**Port 8000 already in use?**
```powershell
php -S localhost:8001
```

**CORS errors?** Already configured in config.php headers

**JSON file permission denied?** Ensure `users.json` has write permissions
