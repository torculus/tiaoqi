tiaoqi_sources = [
  'main.vala',
  'window.vala',
]

tiaoqi_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

tiaoqi_sources += gnome.compile_resources('tiaoqi-resources',
  'tiaoqi.gresource.xml',
  c_name: 'tiaoqi'
)

executable('tiaoqi', tiaoqi_sources,
  vala_args: '--target-glib=2.50',  dependencies: tiaoqi_deps,
  install: true,
)
