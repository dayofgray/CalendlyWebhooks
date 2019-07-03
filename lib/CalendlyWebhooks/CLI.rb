#CLI Controller Class
class CalendlyWebhooks::CLI

    def call
        puts "Welcome to Calendly's Developer Help Center! What would you like to do today?"
        choice
    end

    def choice
        puts "1. Create a webhook"
        puts "2. Delete a webhook"
        puts "3. Find my webhooks"
        puts "4. See sample webhook data"
        puts "5. See my event types"
        puts "6. See information about me"
    end

end