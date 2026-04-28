<?php
require_once 'config.php';

// Get POST data
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';

// Validate inputs
if (empty($email) || empty($password)) {
    sendResponse(false, 'Email and password are required');
}

if (!validateEmail($email)) {
    sendResponse(false, 'Invalid email format');
}

// Load users from JSON
$users = loadUsers();

// Find user by email
$user = null;
foreach ($users as $u) {
    if ($u['email'] === $email) {
        $user = $u;
        break;
    }
}

if (!$user) {
    sendResponse(false, 'User not found');
}

// Verify password
if (!password_verify($password, $user['password'])) {
    sendResponse(false, 'Invalid password');
}

// Login successful
$userData = [
    'id' => $user['id'],
    'email' => $user['email'],
    'firstname' => $user['firstname'],
    'lastname' => $user['lastname'],
    'phone' => $user['phone'] ?? ''
];

sendResponse(true, 'Login successful', $userData);
?>
