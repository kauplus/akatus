# Tell I18n where to find translation files.
locales = File.expand_path(File.join(File.dirname(__FILE__), '..', 'locales', 'pt-BR.yml'))
I18n.load_path << locales
