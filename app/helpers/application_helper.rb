module ApplicationHelper
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

    private
    def paperclip_file_url(item, attribute)
      (item.send(attribute).s3_permissions == :private) ? item.send(attribute).expiring_url(10.minutes) : item.send(attribute).url
    end
end
