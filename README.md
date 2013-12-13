Easily Change iOS Build Configurations
======================

This code is based on the Mobile Tuts+ tutorial: http://bit.ly/1b2k2Mk

The Challenge
======================
Developers often work in multiple environments at the same time or need to use different variables (URLs, Analytics codes, etc.) for the development, staging and production environments. How do you create a simple, effective way to quickly change your build configuration and all of the associated variables each configuration requires?

Many iOS developers use a "constants" file to define the QA or PROD variables and then manually update their code to switch out these variables prior to distribution. While this works for smaller projects with a limited number of variables, the opportunity to overlook a change or variable is always there - not to mention trying to remember which variables need to be changed and when. This is a pain!

This solution seeks to resolve this manual process by leveraging the ability to customize schemes and configurations in Xcode. Properly implemented, this approach allows you to change your build configuration by simply selecting the desired scheme from the drop-down list prior to running the application. Simple!

The Approach
======================
1. In order to differentiate between builds, we need to know the current configuration. Xcode allows you to add or edit configurations within the Project Navigator (from the INFO tab). Once you have added your different environments to the Configuration panel, you need to make each configuration available to the application at runtime. You accomplish this by editing the -Info.plist file and adding the key "Configuration" and value ${CONFIGURATION}. 

        You capture the configuration within your app using the following code:
        NSString *configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];

2.  Next create custom Xcode schemes for each of your environments and assign each the corresponding configuration you just defined in the Info panel.

3.  Now you need a way to differentiate variables between the configurations you've created. This is done by creating a configuration file. In this example, we use a Property List. The .plist contains dictionaries for each of our configurations (development, production, etc.) and key/value pairs for each of the build specific variables we need. For example, Google Analytics or Flurry codes, APIs, FacebookIDs, etc.

        Essentially your configurations dictionary will look something like this:
        
                {
                  {"development": {
                    "GACode":"DevGoogleCode",
                    "FlurryCode":"DevFlurryCode",
                    "API":"http://dev.webapi.com"},
                  }
                  {"production": {
                    "GACode":"ProdGoogleCode",
                    "FlurryCode":"ProdFlurryCode",
                    "API":"http://prod.webapi.com"},
                  }
                }

4.  The final step is to create a Configuration Class that interprets which configuration the build was initiated with and read the corresponding variables from our Configurations.plist.

5.  To implement the solution, you simply need to import the Configuration Class into the file which requires any of these multi-option variables. When you need to reference any of these environment-dependent variables, you just call the value from our Configuration Class:
 
                NSString *googleAnalyticsCode = [ConfigurationClass GACode];

Once the code is implemented, switching between build configurations is as simple as changing the scheme - literally a simple select from the scheme drop-down - before running your app.

Conclusion
======================
Setting up this solution requires some planning and time to implement - you're editing project settings, creating a .plist and adding values, coding a new class and implementing each of the variables within that class, etc. However, the subsequent ease of switching between build configurations and avoiding the manual code updates and changes that are required (not to mention the time lost if you forget to make a required change) more than make up for the upfront expense necessary to implement this simple solution.

Thanks to the folks at mobile tuts+ for the tutorial!


