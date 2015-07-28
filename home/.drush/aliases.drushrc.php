<?php

exec('git remote -v 2> /dev/null', $remotes);
foreach ($remotes as $remote_raw) {
  if (strpos($remote_raw, '@') !== FALSE) { continue; }

  preg_match('{(?<name>.*?)\s+(?<host>.*?):(?<path>(?<basename>.*?)(?:/public_html|/httpdocs)?)(?:/.git)}', $remote_raw, $git_remote);

  $host = $git_remote['host'];
  $root = $git_remote['path'];
  $site_name = basename($git_remote['basename']);
  $uri = basename($site_name) . '.' . $host;

  $alias_key = $git_remote['name'] . '-' . $site_name;

  $remote = array(
    'remote-host' => $host,
    'root' => $root,
    'uri' => $uri,
    'path-aliases' => array(
      '%files' => 'sites/default/files',
    ),
  );

  $aliases[$alias_key] = $remote;
}
