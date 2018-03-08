<?php
  //Set Default TimeZone
  date_default_timezone_set('America/Los_Angeles');

  /*return array(
    // In PHP 5.4+, PsySH will default to your `cli.pager` ini setting. If this
    // is not set, it falls back to `less`. It is recommended that you set up
    // `cli.pager` in your `php.ini` with your preferred output pager.
    //
    // If you are running PHP 5.3, or if you want to use a different pager only
    // for Psy shell sessions, you can override it here.
    'pager' => 'more',

    // By default, PsySH will use a 'forking' execution loop if pcntl is
    // installed. This is by far the best way to use it, but you can override
    // the default by explicitly enabling or disabling this functionality here.
    'usePcntl' => false,

    // PsySH uses readline if you have it installed, because interactive input
    // is pretty awful without it. But you can explicitly disable it if you
    // hate yourself or something.
    'useReadline' => false,

    // "Default includes" will be included once at the beginning of every PsySH
    // session. This is a good place to add autoloaders for your favorite
    // libraries.
    'defaultIncludes' => array(
      __DIR__.'/include/bootstrap.php',
    ),

    // While PsySH ships with a bunch of great commands, it's possible to add
    // your own for even more awesome. Any Psy command added here will be
    // available in your Psy shell sessions.
    'commands' => array(

      // The `parse` command is a command used in the development of PsySH.
      // Given a string of PHP code, it pretty-prints the
      // [PHP Parser](https://github.com/nikic/PHP-Parser) parse tree. It
      // prolly won't be super useful for most of you, but it's there if you
      // want to play :)
      new \Psy\Command\ParseCommand,
    ),

    // PsySH ships with presenters for scalars, resources, arrays, and objects.
    // But you're not limited to those presenters. You can enable additional
    // presenters (like the included MongoCursorPresenter), or write your own!
    'presenters' => array(
      new \Psy\Presenter\MongoCursorPresenter,
    ),

    // You can disable tab completion if you want to. Not sure why you'd want to.
    'tabCompletion' => false,

    // You can write your own tab completion matchers, too! Here are some that enable
    // tab completion for MongoDB database and collection names:
    'tabCompletionMatchers' => array(
      new \Psy\TabCompletion\Matcher\MongoClientMatcher,
      new \Psy\TabCompletion\Matcher\MongoDatabaseMatcher,
    ),
  );*/
?>
