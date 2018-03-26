module ApplicationHelper
    # Returns the full title on a per-page basis.
   def full_title(page_title = '')
     base_title = "IT Мероприятия"
       if page_title.empty?
         base_title
       else
         page_title + " | " + base_title
       end
   end

   def error_msg(controller)
    controller.controller_name == 'events'? @event : @organizer
   end

end
