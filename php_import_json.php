<?php 

// Read the JSON file
$json = file_get_contents('my_data.json'); 

// Check if the file was read successfully
if ($json === false) {
    die('Error reading the JSON file');
}

// Decode the JSON file
$json_data = json_decode($json, true); 

// Check if the JSON was decoded successfully
if ($json_data === null) {
    die('Error decoding the JSON file');
}

// Display data
echo "<pre>";
print_r($json_data);
echo "</pre>";

// Source: https://www.geeksforgeeks.org/how-to-parse-a-json-file-in-php/
?>

