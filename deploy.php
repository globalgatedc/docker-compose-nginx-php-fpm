<?php
namespace Deployer;

require 'recipe/common.php';

// Project name
set('application', 'ABC');

// Project repository
set('repository', 'git@bitbucket.org:qualitypress/abc.git');

// [Optional] Allocate tty for git clone. Default value is false.
set('git_tty', true); 

// Shared files/dirs between deploys 
set('shared_files', [
    'web/.htaccess',
    'quality/src/propel/build/conf/qcommerce-conf.php',
    'quality/app/config/variables.yml'
]);
set('shared_dirs', [
    'web/arquivos',
    'web/resize',
    'quality/var'
]);

// Writable dirs by web server 
set('writable_dirs', [
    'web/arquivos',
    'web/resize',
    'quality/var',
    'quality/app/config'
]);

set('clear_paths', [
    'quality/var/cache',
]);

// Hosts
host('prod')
    ->hostname('1.1.1.1')
    ->stage('prod')
    ->user('abc')
    ->set('branch', 'master')
    ->set('deploy_path', '/home/blumenauilum/www/');

host('homolog')
    ->hostname('1.1.1.1')
    ->stage('homolog')
    ->user('abc')
    ->set('branch', 'release/ambiente_testes')
    ->set('deploy_path', '/home/blumenauilum/www_dev/');  

// Tasks
desc('Deploy your project');
task('deploy', [
    'deploy:info',
    'deploy:prepare',
    'deploy:lock',
    'deploy:release',
    'deploy:update_code',
    'deploy:shared',
    'deploy:writable',
    'deploy:portomontt:vendors',
    'deploy:portomontt:assets',
    'deploy:clear_paths',
    'deploy:symlink',
    'deploy:unlock',
    'cleanup',
    'success'
]);

/* task('deploy:portomontt:vendors', function(){ */
/*     run('cd {{deploy_path}}/release/quality && composer install --verbose --prefer-dist --no-progress --no-interaction --optimize-autoloader'); */
/* }); */

//mesma coisa mas em vez de usar o composer instalado localmente usa ele em um container
task('deploy:portomontt:vendors', function(){
    run('cd {{deploy_path}}/release/quality && docker run --rm -v $(pwd):/app composer --verbose --prefer-dist --no-progress --no-interaction --optimize-autoloader');
});

/* task('deploy:portomontt:assets', function(){ */
/*     run('cd {{deploy_path}}/release/web && npm install'); */
/*     run('cd {{deploy_path}}/release/web && grunt'); */
/*     run('cd {{deploy_path}}/release/web/admin/assets && npm install'); */
/*     run('cd {{deploy_path}}/release/web/admin/assets && gulp'); */
/*     run('rm -rf {{deploy_path}}/release/web/node_modules'); */
/*     run('rm -rf {{deploy_path}}/release/web/admin/assets/node_modules'); */
/* }); */

//adaptando para rodar com docker também
task('deploy:portomontt:assets', function(){
    run('cd {{deploy_path}}/release/web && docker run --rm -v $(pwd):/app node sh -c "cd /app/web && npm install && grunt"');
    run('cd {{deploy_path}}/release/web/admin/assets && docker run --rm -v $(pwd):/app node sh -c "cd /app/web && npm install && gulp"');
    run('rm -rf {{deploy_path}}/release/web/node_modules');
    run('rm -rf {{deploy_path}}/release/web/admin/assets/node_modules');
});

// [Optional] If deploy fails automatically unlock.
after('deploy:failed', 'deploy:unlock');
