use strict;
use warnings;
 
use Irssi;

our $VERSION = '0.1';
our %IRSSI = (
    author      => 'Spenser Jones',
    contact     => 'spenser.e.jones@gmail.com',
    name        => 'Nicklist FIFO for TMux',
    description => 'Handle automatic creation of FIFO for TMux',
    license     => 'Public Domain',
);

sub tmux_fifo {
  Irssi::command('nicklist fifo');
  Irssi::timeout_add_once(2000, sub {
    Irssi::command('nicklist fifo');
  },'');
}

Irssi::command_bind('nicklist tmux_fifo', \&tmux_fifo);
