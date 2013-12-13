TUTBuildConfigurations
======================

This code is based on the Mobile Tuts+ tutorial located here: http://bit.ly/1b2k2Mk

The Challenge
======================
Developers often work in multiple environments at the same time or need to use different variables (URLs, Analytics codes, etc.) for the development, staging and production environments. Many iOS developers use a "constants" file to define the different variables and then manually update their code to switch out these variables prior to distribution based on the configuration they are building. While this works for smaller projects with a limited number of variables, the opportunity to overlook a change or variable is always there - not to mention trying to remember which variables need to be changed and when. This solution seeks to resolve this manual process by leveraging the ability to customize configurations in Xcode.

The Approach
======================
1. In order to differentiate between builds, we need to know the current configuration. Xcode allows you to add or edit configurations within the Project Navigator (from the INFO tab). Once you have added your different environments to the Configuration panel, you need to make each configuration available to the application at runtime. You accomplish this by editing the -Info.plist file and adding the key "Configuration" and value ${CONFIGURATION}. You capture the configuration within your app using the following code:

    NSString *configuration = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Configuration"];

2.  Next create custom Xcode schemes for each of the configurations you defined.

3.  Now you need a way to differentiate variables between the configurations you've created. This is done by creating a configuration file. In this example, we use a Property List. The .plist contains dictionaries for each of our configurations (development, production, etc.) and key/value pairs for each of the build specific variables we need. For example, Google Analytics or Flurry codes, APIs, FacebookIDs, etc.

{
  {"development": {
    "GACode":"DevGoogleCode",
    "FlurryCode":"DevFlurryCode",
    "API":"http://dev.webapi.com"},
  }
  {"production": {
    "GACode":"ProdGoogleCode",
    "FlurryCode":"ProdFlurryCode",
    "API":"http://Prod.webapi.com"},
  }
}

4.  The final step is to create a Configuration Class that interprets which configuration the build was initiated with and read the corresponding variables from our Configurations.plist.

5.  To implement the solution, you simply need to import the Configuration Class into the file which requires any of these multi-option variables. When any of these variables needs assignment, you simply assign it the value from our Configuration Class:
    [ConfigurationClass GACode]

Once the code is implemented, switching between build configurations is as simple as changing the scheme - literally a simple select from the scheme drop-down - before running your app.

Conclusion
======================
Setting up this solution requires some planning and time to implement - you're editing project settings, creating a .plist and adding values, coding a new class and implementing each of the variables within that class, etc. However, the subsequent ease of switching between build configurations and avoiding the manual code updates and changes that are required (not to mention the time lost if you forget to make a required change) more than make up for the upfront expense necessary to implement this simple solution.

Thanks to the folks at mobile tuts+ for the tutorial!


