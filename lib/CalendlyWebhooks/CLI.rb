#CLI Controller Class

class CalendlyWebhooks::CLI

    def call
        puts "\nWelcome to Calendly's Developer Help Center!"
        sleep(1)
        choice
        input = ""
        input = gets.chomp
    while input != "end" && input != "done"
        if input == "1"
            puts "\n"
            create_webhook
            puts "\n"
            input = ""
            optional_exit
            input = "end"
        elsif input == "2"
            puts "\n"
            puts "Do you know the ID of the webhook that you would like to delete? (y/n)"
            id = gets.strip
            if id == "y"
                puts "\n"
                delete_webhook
                input = ""
                puts "\n"
                optional_exit
                input = "end"
            elsif id == "n"
                puts "You will be unable to delete a webhook without the ID, please try finding the webhook first using option 3 from the main menu"
                input = ""
                sleep(2)
                call
            end
        elsif input == "3"
            puts "\n"
            find_webhooks
            puts "\n"
            input = ""
            optional_exit
            input = "end"
        elsif input == "4"
            puts "\n"
            sample_webhook_data
            puts "\n"
            input = ""
            optional_exit
            input = "end"
        elsif input == "5"
          puts "\n"
          full_event_types
            input = ""
            optional_exit
            input = "end"
        elsif input == "6"
            puts "\n"
            see_me
            puts "\n"
            input = ""
            optional_exit
            input = "end"
        elsif input == "return"
            input = ""
            call
        elsif input = "end" || input = "done"
          finish
        elsif input != "1" && input != "2" && input != "3" && input != "4" && input != "5" && input != "6" && input != "return" && input != "end" && input != ""
          puts "\n"  
          puts "Please enter a valid number 1-6 or 'end' to end the program"
            call
        end
    end
        if input == "end"
            finish
        end
        end

    def finish #end of program
            puts "For security reasons, this program will self destruct in 5..."
            sleep(1) 
            puts "4..."
            sleep(1) 
            puts "3..." 
            sleep(1) 
            puts "2..." 
            sleep(1) 
            puts "1..." 
            sleep(1)
            puts "BOOM!"
    end

    def choice
        puts "\nWhat would you like to do today?"
        sleep(1)
        puts "\n"
        puts "  1. Create a webhook"
        puts "  2. Delete a webhook"
        puts "  3. Find my webhooks"
        puts "  4. See sample webhook data"
        puts "  5. See my event types"
        puts "  6. See information about me"
        puts "\n"
        puts "  Type end at any time to end the program"
    end

    def optional_exit #allows a user to exit the program
        puts "Would you like to end the program or return to main menu? (Type 'end' to end the program or 'return' to return to the main menu)"
        decision = gets.strip
        # if decision == "end"
        #     input = "end"
        #     call
        if decision == "return"
            call
        elsif decision != "end" && decision != "return"
            puts "Please enter 'end' or 'return'"
            optional_exit
        end
    end

    def create_webhook #creates a new webhook
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/webhook-subscriptions")
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "What is your webhook destination URL"
        destination = gets.strip
        hook.webhook_url = destination
        hook.endpoint_url = "https://calendly.com/api/v1/hooks"
        hook.make_post_request
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        sleep(1)
        puts "\n"
        puts "Webhook created!"
        sleep(1)
        puts "\n"
        puts "Feel free to test out your new webhook by booking a test event with yourself using your Calendly scheduling link!"
    end
    
    def delete_webhook #deletes an identified webhook
        puts "What is the Hook ID of the webhook that you would like to delete?"
        id = gets.strip
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/delete-webhook-subscription")
        hook.endpoint_url = "https://calendly.com/api/v1/hooks/#{id}"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "\n"
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        hook.make_delete_request
        sleep(1)
        puts "\n"
        puts "Webhook deleted!"
    end

    def find_webhooks #fetches a list of the webhooks tied to a user's account
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/get-list-of-webhook-subscriptions")
        hook.endpoint_url = "https://calendly.com/api/v1/hooks"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "\n"
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        puts "\n"
        responses = []
        response = hook.make_get_request.body.split("hooks").each do
          |hook| responses << hook
        end
        responses.shift
        data = responses.each {|response| response[0..2] = ""}
        sleep(1)
        puts "Here is the webhook data associated with that API token"
        puts "\n"
        data.each.with_index(1) { |val,index| puts "#{index}. #{val} \n\n"}
    end

    def sample_webhook_data #displays sample webhook data
        puts "  \n
  'event':'invitee.created', \n
  'time':'2018-03-14T19:16:01Z', \n
  'payload':{ \n
    'event_type':{   \n
      'uuid':'CCCCCCCCCCCCCCCC', \n
      'kind':'One-on-One', \n
      'slug':'event_type_name', \n
      'name':'Event Type Name', \n
      'duration':15, \n
      'owner':{   \n
        'type':'users', \n
        'uuid':'DDDDDDDDDDDDDDDD' \n
      } \n
    }, \n
    'event':{   \n
      'uuid':'BBBBBBBBBBBBBBBB', \n
      'assigned_to':[   \n
        'Jane Sample Data' \n
      ], \n
      'extended_assigned_to':[   \n
        {   \n
          'name':'Jane Sample Data', \n
          'email':'user@example.com', \n
          'primary':false \n
        } \n
      ], \n
      'start_time':'2018-03-14T12:00:00Z', \n
      'start_time_pretty':'12:00pm - Wednesday, March 14, 2018', \n
      'invitee_start_time':'2018-03-14T12:00:00Z', \n
      'invitee_start_time_pretty':'12:00pm - Wednesday, March 14, 2018', \n
      'end_time':'2018-03-14T12:15:00Z', \n
      'end_time_pretty':'12:15pm - Wednesday, March 14, 2018', \n
      'invitee_end_time':'2018-03-14T12:15:00Z', \n
      'invitee_end_time_pretty':'12:15pm - Wednesday, March 14, 2018', \n
      'created_at':'2018-03-14T00:00:00Z', \n
      'location':'The Coffee Shop', \n
      'canceled':false, \n
      'canceler_name':null, \n
      'cancel_reason':null, \n
      'canceled_at':null \n
    }, \n
    'invitee':{   \n
      'uuid':'AAAAAAAAAAAAAAAA', \n
      'first_name':'Joe', \n
      'last_name':'Sample Data', \n
      'name':'Joe Sample Data', \n
      'email':'not.a.real.email@example.com',\n
      'text_reminder_number':'+14045551234', \n
      'timezone':'UTC', \n
      'created_at':'2018-03-14T00:00:00Z', \n
      'is_reschedule':false, \n
      'payments':[   \n
        {   \n
          'id':'ch_AAAAAAAAAAAAAAAAAAAAAAAA', \n
          'provider':'stripe', \n
          'amount':1234.56, \n
          'currency':'USD', \n
          'terms':'sample terms of payment (up to 1,024 characters)', \n
          'successful':true \n
        } \n
      ], \n
      'canceled':false, \n
      'canceler_name':null, \n
      'cancel_reason':null, \n
      'canceled_at':null \n
    }, \n
    'questions_and_answers':[   \n
      {   \n
        'question':'Skype ID', \n
        'answer':'fake_skype_id' \n
      }, \n
      {   \n
        'question':'Facebook ID', \n
        'answer':'fake_facebook_id' \n
      }, \n
      {   \n
        'question':'Twitter ID', \n
        'answer':'fake_twitter_id' \n
      }, \n
      {   \n
        'question':'Google ID', \n
        'answer':'fake_google_id' \n
      } \n
    ], \n
    'questions_and_responses':{   \n
      '1_question':'Skype ID', \n
      '1_response':'fake_skype_id', \n
      '2_question':'Facebook ID', \n
      '2_response':'fake_facebook_id', \n
      '3_question':'Twitter ID', \n
      '3_response':'fake_twitter_id', \n
      '4_question':'Google ID', \n
      '4_response':'fake_google_id' \n
    }, \n
    'tracking':{   \n
      'utm_campaign':null, \n
      'utm_source':null, \n
      'utm_medium':null, \n
      'utm_content':null, \n
      'utm_term':null, \n
      'salesforce_uuid':null \n
    }, \n
    'old_event':null, \n
    'old_invitee':null, \n
    'new_event':null, \n
    'new_invitee':null \n
  } \n
}"
    end
    
    def see_event_types #fetches event types
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/user-event-types")
        hook.endpoint_url = "https://calendly.com/api/v1/users/me/event_types"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "\n"
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        responses = []
        hook.make_get_request.body.split("event_types").each {|event_type| responses << event_type}
        sleep(1)
        puts "\n"
        puts "Here are the event types associated with that API token!"
        @responses = responses
        responses
    end
    
    def format_event_types(responses) #formats event type strings
      initial_events = []
      initial_events = responses.collect {|response| x = response.gsub(/.*(?=name)/,'').gsub(/(?=","url).*/,'')
      x[0..6] = ""
      x
      }
      initial_events.shift
      puts "\n"
      puts initial_events
    end

    def see_specific_event_type(name) #finder that enables user to find more information about a specific event type by name
      final_list = @responses.select {|response| response.include?("#{name}")}
      # puts final_list
    end

    def full_event_types #allows users to see a list of event types or further details if they would like
      format_event_types(see_event_types)
      # see_event_types
          puts "\n"
          puts "Would you like to look at a specific event type in further detail? (y/n)"
          answer = gets.strip.downcase
          if answer == "y"
            puts "\n"
            puts "What event type would you like more information on? (Please enter the name of the event type)"
              event_type = gets.strip
              if see_specific_event_type(event_type).count >= 1
               puts see_specific_event_type(event_type)
              else
                puts "\n"
                puts "There is no event type by that name. Let's pull your event types again!"
                full_event_types
              end
            end
    end

    def see_me #gets user information
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/about-me")
        hook.endpoint_url = "https://calendly.com/api/v1/users/me"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "\n"
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        responses = []
        response = hook.make_get_request.body
        sleep(1)
        puts "\n"
        puts "Here is the information about the user associated with that API token!"
        puts "\n"
        puts response
end
end