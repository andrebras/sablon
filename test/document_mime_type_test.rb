# -*- coding: utf-8 -*-
require 'test_helper'
require 'filemagic'

class DocumentMimeTypeTest < Sablon::TestCase
  def setup
    super

    @base_path     = Pathname.new(File.expand_path("../", __FILE__))
    @template_path = @base_path + 'fixtures/mime_type_example.docx'
    @output_path   = @base_path + 'sandbox/mime_type_example.docx'
  end

  def test_maintain_template_mime_type
    template_mime_type = FileMagic.new(FileMagic::MAGIC_MIME).file(@template_path.to_s).split(';').first

    template = Sablon.template @template_path
    template.render_to_file @output_path, {type: template_mime_type}

    document_mime_type = FileMagic.new(FileMagic::MAGIC_MIME).file(@output_path.to_s).split(';').first

    assert_equal template_mime_type, document_mime_type
  end
end
