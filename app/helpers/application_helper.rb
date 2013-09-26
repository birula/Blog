require 'redcarpet'

module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def flash_messages
    flash.collect do |key, msg|
      content_tag :p, msg, id: key, class: "flash_message"
      end.join.html_safe
    end

    def error_messages_for(resource)
      render partial: "shared/error_messages", locals: { resource: resource }
    end

    def menu_top(file=nil)
      render partial: "shared/#{file}menu_top"
    end

    def menu_left(file=nil)
      render partial: "shared/#{file}menu_left"
    end

    def textilize(text)
      RedCloth.new(text).to_html.html_safe
    end

    def translate_attribute(model, attribute)
      model.human_attribute_name(attribute)
    end
    alias_method :ta, :translate_attribute

    def display_text(item, attribute)
      if attribute == 'log'
        content_tag :pre, item.send(attribute)
      else
        super
      end
    end
    def display_paperclip(item, attribute)
      if item.send(attribute).content_type =~ /^image\/.+/
        image_tag paperclip_file_url(item, attribute)
      else
        link_to item.send("#{attribute}_file_name"), paperclip_file_url(item, attribute)
      end
    end
    def display_string(item, attribute)
      if attribute == 'hashed_code'
        item.hashed_code.nil? ? "Nada foi gerado." : link_to(item)
      else
        super
      end
    end
    def table_paperclip_field(attribute, item)
      link_to item.send("#{attribute}_file_name"), paperclip_file_url(item, attribute)
    end


def link_to_export_excel(model, url, html_options = {})
    html_options.reverse_merge!(:class => "btn btn-mini")
    link_to t("export", model: model.model_name.human), url, html_options

    link_to url, html_options do
      html = content_tag :i, " ", :class => "icon_excel"
      html += t("export")
      html.html_safe
    end
  end

  def link_to_new(model, url, html_options = {})
    html_options.reverse_merge!(:class => "btn btn-success")
    link_to t("new", model: model.model_name.human), url, html_options
  end

  def link_to_edit(url, html_options = {})
    html_options.reverse_merge!(:class => "btn btn-mini")
    link_to url, html_options do
      html = content_tag :i, " ", :class => "icon-pencil"
      html += t("edit")
      html.html_safe
    end
  end

  def link_to_destroy(url, html_options = {})
    html_options.reverse_merge!(:confirm => 'Are you sure?', :method => :delete, :class => "btn btn-mini")
    link_to url, html_options do
      html = content_tag :i, " ", :class => "icon-trash"
      html += t("destroy")
      html.html_safe
    end
  end

  def section(title="", &block)
    content_tag :div, :class => "section" do
      html  = ""
      html  += content_tag :h3, title if title.present?
      html  += content_tag :div, :class => "in", &block
      html.html_safe
    end
  end


    private
    def paperclip_file_url(item, attribute)
      (item.send(attribute).s3_permissions == :private) ? item.send(attribute).expiring_url(10.minutes) : item.send(attribute).url
    end
end
