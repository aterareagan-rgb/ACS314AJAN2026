<?php
require_once 'config.php';

// Get POST data
$firstname = isset($_POST['firstname']) ? trim($_POST['firstname']) : '';
$lastname = isset($_POST['lastname']) ? trim($_POST['lastname']) : '';
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$phone = isset($_POST['phone']) ? trim($_POST['phone']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';
$confirmPassword = isset($_POST['confirmPassword']) ? trim($_POST['confirmPassword']) : '';

// Validate inputs
if (empty($firstname) || empty($lastname) || empty($email) || empty($phone) || empty($password) || empty($confirmPassword)) {
    sendResponse(false, 'All fields are required');
}

if (!validateEmail($email)) {
    sendResponse(false, 'Invalid email format');
}

if (!validatePassword($password)) {
    sendResponse(false, 'Password must be at least 6 characters long');
}

if ($password !== $confirmPassword) {
    sendResponse(false, 'Passwords do not match');
}

// Load existing users
$users = loadUsers();

// Check if email already exists
foreach ($users as $u) {
    if ($u['email'] === $email) {
        sendResponse(false, 'Email already registered');
    }
}

// Create new user
$newUser = [
    'id' => uniqid(),
    'firstname' => $firstname,
    'lastname' => $lastname,
    'email' => $email,
    'phone' => $phone,
    'password' => password_hash($password, PASSWORD_BCRYPT),
    'created_at' => date('Y-m-d H:i:s')
];

// Add to users array
$users[] = $newUser;

// Save users
saveUsers($users);

// Return success
$userData = [
    'id' => $newUser['id'],
    'firstname' => $newUser['firstname'],
    'lastname' => $newUser['lastname'],
    'email' => $newUser['email'],
    'phone' => $newUser['phone']
];

sendResponse(true, 'Signup successful', $userData);
?>
