class kibana::install {
  vcsrepo { '/opt/kibana':
    ensure   => $::kibana::ensure,
    provider => 'git',
    source   => $::kibana::git_source,
    revision => $::kibana::git_hash,
  }
}
