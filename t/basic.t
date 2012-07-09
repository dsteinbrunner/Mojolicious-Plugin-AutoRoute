use Mojo::Base -strict;

use Test::More 'no_plan';

use Mojolicious::Lite;
use Test::Mojo;

plugin 'AutoRoute', {ignore => [qw/layouts include/]};

my $t = Test::Mojo->new;

# Get
$t->get_ok('/')->content_like(qr#\Qindex.html.ep#);
$t->get_ok('/foo')->content_like(qr#\Qfoo.html.ep#);
$t->get_ok('/foo/bar')->content_like(qr#\Qfoo/bar.html.ep#);
$t->get_ok('/foo/bar/baz')->content_like(qr#\Qfoo/bar/baz.html.ep#);
$t->get_ok('/layouts/common')->status_is(404);
$t->get_ok('/include/foo')->status_is(404);

# Post
$t->post_ok('/')->content_like(qr#\Qindex.html.ep#);
$t->post_ok('/foo')->content_like(qr#\Qfoo.html.ep#);
$t->post_ok('/foo/bar')->content_like(qr#\Qfoo/bar.html.ep#);
$t->post_ok('/foo/bar/baz')->content_like(qr#\Qfoo/bar/baz.html.ep#);
$t->post_ok('/layouts/common')->status_is(404);
$t->post_ok('/include/foo')->status_is(404);
