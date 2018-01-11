<?php
if (PHP_SAPI == 'cli-server') {
    // To help the built-in PHP dev server, check if the request was actually
    // for something which should probably be served as a static file
    $url  = parse_url($_SERVER['REQUEST_URI']);
    $file = __DIR__ . $url['path'];
    if (is_file($file)) {
        return false;
    }
}

require __DIR__ . '/../vendor/autoload.php';

//session_start();

// Instantiate the app
$settings = require __DIR__ . '/../src/settings.php';
$app = new \Slim\App($settings);

// Set up dependencies
require __DIR__ . '/../src/dependencies.php';

// Register middleware
require __DIR__ . '/../src/middleware.php';

// Register routes -------------------------------------------------------------
// IMPORTANT: Require dynamic routes after static ones
require __DIR__ . '/../src/routes.php';
// require __DIR__ . '/../src/login.php';
// require __DIR__ . '/../src/registration.php';
// require __DIR__ . '/../src/games.php';
// require __DIR__ . '/../src/get_profile.php';
// require __DIR__ . '/../src/game_detail.php';
// require __DIR__ . '/../src/delete_game.php';
// require __DIR__ . '/../src/post_location.php';
// require __DIR__ . '/../src/get_location.php';
// require __DIR__ . '/../src/rsvp.php';
// require __DIR__ . '/../src/approve_admin.php';
// require __DIR__ . '/../src/approve_location.php';
// require __DIR__ . '/../src/pofile-update.php';
// require __DIR__ . '/../src/stats-update.php';
// require __DIR__ . '/../src/change_password.php';
// require __DIR__ . '/../src/comments.php';
// require __DIR__ . '/../src/location-update.php';
// require __DIR__ . '/../src/delete_location.php';
// require __DIR__ . '/../src/email_validation.php';

// Add dynamic ones below this line --------------------------------------------i

// Run app
$app->run();

