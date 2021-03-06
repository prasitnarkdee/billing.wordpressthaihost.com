<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit35465a71547cdc5d41f2d4cf3f61cfa3
{
    public static $prefixLengthsPsr4 = array (
        'P' => 
        array (
            'PostFinanceCheckout\\Sdk\\' => 24,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'PostFinanceCheckout\\Sdk\\' => 
        array (
            0 => __DIR__ . '/..' . '/postfinancecheckout/sdk/lib',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit35465a71547cdc5d41f2d4cf3f61cfa3::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit35465a71547cdc5d41f2d4cf3f61cfa3::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInit35465a71547cdc5d41f2d4cf3f61cfa3::$classMap;

        }, null, ClassLoader::class);
    }
}
