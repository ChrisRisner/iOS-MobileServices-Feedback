# iOS - Mobile Services - Feedback
This is a feedback sample which makes use of Windows Azure Mobile Services for it's data storage.  It can be used as a feedback form inside of an application.  It can also be easily added to an existing iOS project.  This sample was built using XCode, the iOS Framework, and the iOS Mobile Services SDK.

Below you will find requirements and deployment instructions.

## Requirements
* OSX - This sample was built on OSX Lion (10.7.4) but should work with more current releases of OSX.
* XCode - This sample was built with XCode 4.4 and requires at least XCode 4.0 due to use of storyboards and ARC.
* Windows Azure Account - Needed to create and run the Mobile Service.  [Sign up for a free trial](https://www.windowsazure.com/en-us/pricing/free-trial/).

## Source Code Folders
* /source/start - This contains code for the application prior to adding in Mobile Services.
* /source/end - This contains code for the application with Mobile Services and requires client side changes noted below.

## Additional Resources
A blog post has gone up talking about this Feedback sample as well as how to connect multiple clients to the same Mobile Service backend.  You can read it [here](http://chrisrisner.com/Connecting-Multiple-Clients-to-the-Same-Mobile-Service).


#Setting up your Mobile Service
After creating your Mobile Service in the Windows Azure Portal, you'll need to create a table named "Feedback".

#Client Application Changes
In order to run the client applicaiton, you'll need to change a few settings in your application.  After opening the source code in Xcode, open the FeedbackService.m file.  Find the init method and change the <YourMobileServiceUrl> and <YourApplicationKey> to match the values from the Mobile Service you've created.

## Contact

For additional questions or feedback, please contact the [team](mailto:chrisner@microsoft.com).