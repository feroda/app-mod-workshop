<hr/>
<div class='footer'><?php
    # PHP 5.3 syntax. In 7 its more elegant: $name = $_GET['name'] ?? 'john doe';
    $appname = getenv('APP_NAME') ?: 'APP_NAME_UNKNOWN'; # https://stackoverflow.com/questions/5972516/best-way-to-give-a-variable-a-default-value-simulate-perl
    $php_env = getenv('PHP_ENV')  ?: 'PHP_ENV_UNKNOWN'; # https://stackoverflow.com/questions/5972516/best-way-to-give-a-variable-a-default-value-simulate-perl
    $code_repo = getenv('CODE_REPO')  ?: 'https://github.com/Friends-of-Ricc/app-mod-workshop/blob/main/CHANGELOG.md';
    $app_version = file_get_contents('VERSION');

    echo "Welcome to <b>$appname</b> v<b>$app_version</b>!";
    echo "<tt>PHP_ENV=$php_env</tt>";
    echo "<tt>CODE_REPO: <a href='$code_repo' >$code_repo</a></tt>";
    ?>
</div>


<!--
PHP DEBUG: wrap into a function

$debug = false;

if (isset($_ENV['DEBUG'])) {
    $debugValue = strtolower($_ENV['DEBUG']);

    if (in_array($debugValue, ['true', '1'])) {
        $debug = true;
    }
}

-->

</body>
