require 'nokogiri'


# get from: https://raw.githubusercontent.com/srbs/textmate-to-sublime-converter/master/tm2subl.xsl
template_files = Dir["*.{xsl,xlst}"]
template_file  = template_files[0]


template = Nokogiri::XSLT(File.read(template_file))

textmate_snippets = Dir["*.{tmSnippet}"]

textmate_snippets.each { |textmate_snippet|

  textmate_snippet_content = Nokogiri::XML(File.read(textmate_snippet))

  sublime_snippet_content = template.transform(textmate_snippet_content)

  sublime_snippet = textmate_snippet.sub(/\.tmSnippet\z/, '.sublime-snippet')
  File.write(sublime_snippet, sublime_snippet_content)

  File.delete(textmate_snippet)
}


