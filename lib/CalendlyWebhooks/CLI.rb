#CLI Controller Class
require 'net/http'

class CalendlyWebhooks::CLI

    def call
        puts "\nWelcome to Calendly's Developer Help Center!"
        sleep(1)
        choice
        input = ""
        input = gets.chomp
    while input != "end"
        if input == "1"
            create_webhook
            puts "\n"
            input = ""
            optional_exit
        elsif input == "2"
            puts "Do you know the ID of the webhook that you would like to delete? (y/n)"
            id = gets.strip
            if id == "y"
                delete_webhook
                input = ""
                optional_exit
            elsif id == "n"
                puts "You will be unable to delete a webhook without the ID, please try finding the webhook first using option 3 from the main menu"
                input = ""
                sleep(2)
                call
            end
        elsif input == "3"
            find_webhooks
            puts "\n"
            input = ""
            optional_exit
        elsif input == "4"
            sample_webhook_data
            puts "\n"
            input = ""
            optional_exit
        elsif input == "5"
            see_event_types
            puts "\n"
            input = ""
            optional_exit
        elsif input == "6"
            see_me
            puts "\n"
            input = ""
            optional_exit
        elsif input == "return"
            input = ""
            call
        elsif input != "1" && input != "2" && input != "3" && input != "4" && input != "5" && input != "6" && input != "return" && input != "end" && input != ""
            puts "Please enter a valid number 1-6 or 'end' to end the program"
            call
        end
    end
        if input == "end"
            finish
        end
    end

    def finish
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

    def optional_exit
        puts "Would you like to end the program or return to main menu? (Type 'end' to end the program or 'return' to return to the main menu)"
        decision = gets.strip
        if decision == "end"
            finish
        elsif decision == "return"
            call
        else
            puts "Please enter 'end' or 'return'"
            optional_exit
        end
    end

    def create_webhook
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
    
    def delete_webhook
        puts "What is the Hook ID of the webhook that you would like to delete?"
        id = gets.strip
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/delete-webhook-subscription")
        hook.endpoint_url = "https://calendly.com/api/v1/hooks/#{id}"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        hook.make_delete_request
        sleep(1)
        puts "Webhook deleted!"
    end

    def find_webhooks
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/get-list-of-webhook-subscriptions")
        hook.endpoint_url = "https://calendly.com/api/v1/hooks"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        hook.make_get_request
        sleep(1)
        puts "Here is the webhook data associated with that API token"
        puts hook.res.body
    end

    def sample_webhook_data
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
    
    def see_event_types
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/user-event-types")
        hook.endpoint_url = "https://calendly.com/api/v1/users/me/event_types"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        hook.make_get_request
        sleep(1)
        puts "Here are the event types associated with that API token!"
        puts hook.res.body
    end

    def see_me
        hook = CalendlyWebhooks::Request.create_from_scraper("https://developer.calendly.com/docs/about-me")
        hook.endpoint_url = "https://calendly.com/api/v1/users/me"
        doc = hook.documentation
        kind = hook.type
        puts "What is your API token?"
        key = gets.strip
        hook.token = key
        puts "We are are using the #{doc} documentation with a #{kind} request to accomplish this for you"
        hook.make_get_request
        sleep(1)
        puts "Here is the information about the user associated with that API token!"
        puts hook.res.body
end
end