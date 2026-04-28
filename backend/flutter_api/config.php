<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Database configuration (Optional - use if you have MySQL)
// const DB_HOST = 'localhost';
// const DB_USER = 'root';
// const DB_PASS = '';
// const DB_NAME = 'car_dealership';

// Using JSON file storage for simplicity
const USERS_FILE = __DIR__ . '/users.json';

// Load users from JSON file
function loadUsers() {
    if (!file_exists(USERS_FILE)) {
        return [];
    }
    $json = file_get_contents(USERS_FILE);
    return json_decode($json, true) ?? [];
}

// Save users to JSON file
function saveUsers($users) {
    file_put_contents(USERS_FILE, json_encode($users, JSON_PRETTY_PRINT));
}

// Response helper
function sendResponse($success, $message, $data = null) {
    echo json_encode([
        'success' => $success ? 1 : 0,
        'message' => $message,
        'data' => $data ?? []
    ]);
    exit;
}

// Validation helpers
function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

function validatePassword($password) {
    return strlen($password) >= 6;
}
?>
