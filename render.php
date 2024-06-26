<?php
$requestedPath = $_SERVER['REQUEST_URI'];
$basePath = '/~pxd222/Blog';

// Remove the base path from the requested path
$requestedPath = str_replace($basePath, '', $requestedPath);

// Remove the trailing slash (if present)
$requestedPath = rtrim($requestedPath, '/');

// Define the path to your HTML files
$htmlFilesDir = __DIR__ . '/frontend';

// Determine the HTML file to render based on the requested path
switch ($requestedPath) {
    case '':
        $htmlFile = $htmlFilesDir . '/index.html';
        break;
    case '/project1':
        $htmlFile = $htmlFilesDir . '/project1.html';
        break;
    case '/project2':
        $htmlFile = $htmlFilesDir . '/project2.html';
        break;
    default:
        http_response_code(404);
        echo 'Page not found';
        exit;
}

// Render the HTML file
if (file_exists($htmlFile)) {
    require $htmlFile;
} else {
    http_response_code(404);
    echo 'Page not found';
}