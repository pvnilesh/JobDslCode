class createfile {
  file { 'C:/testfile.txt':
      ensure => file,
      content => 'This is a test file.',
  }
}
