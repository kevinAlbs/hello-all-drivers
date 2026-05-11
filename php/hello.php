<?php
require __DIR__ . '/vendor/autoload.php';

$client = new MongoDB\Client('mongodb://localhost:27017');
$result = $client->admin->command(['ping' => 1]);
var_dump(iterator_to_array($result)[0]);
