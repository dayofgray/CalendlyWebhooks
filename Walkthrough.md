What website will you be scraping?
    *https://developer.calendly.com/docs*
What will you need to do with the data you return from scraping?
    *API is being updated all of the time so I want to take input from the user and and then use that as a parameter for which page on that site I'm going to scrape for the URL*
What classes will you be using?
    *CLI, Scraper, and Request*
What will be the flow of displaying data for your application. ex How will your CLI portion work.
    *see below*
How will you display data one level deep to the user?
*showing sample webhook data* unsure on this one
What will need to be in your README file?
*installation instructions and how to test these webhooks*

Welcome to Calendly's Developer Help Center! What would you like to do today?

*NOTE For each of these options, you will need your API token, which can be found at the top of your Integrations page

1. Create a webhook
2. Delete a webhook
3. Find my webhooks
4. See sample webhook data
5. See my event types
6. See information about me

Choice 1
    *hard-codes endpoint URL*
    What data would you like to pass in this webhook?
        1. Newly booked events
        2. Canceled events
        3. Both
    What is your API Token?
    *sets token instance variable*
    What is your destination URL?
    *sets destination instance variable*
    Webhook created, test it out!
    Would you like to exit or return to main menu?

Choice 2
    What is your API Token?
    *sets token instance variable*
    What is your hook ID?
        If you do not know your hook ID, try find my webhooks (option 3)
    *hard-codes endpoint URL with hook ID*
    Webhook deleted!
    Would you like to exit or return to main menu?

Choice 3
    *hard-codes endpoint URL*
    What is your API Token?
    *sets token instance variable*
    Displays Webhook information, including IDs
    Would you like to exit or return to main menu?

Choice 4
    Display sample webhook data
    Would you like to exit or return to main menu?

Choice 5
    *hard-codes endpoint URL*
    What is your API Token?
    *sets token instance variable*
    Displays event types
    Would you like to exit or return to main menu?

Choice 6
    *hard-codes endpoint URL*
    What is your API Token?
    *sets token instance variable*
    Displays user information
    Would you like to exit or return to main menu?
