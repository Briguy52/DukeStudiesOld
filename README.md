# DukeStudies

DukeStudies is a native iOS app that uses Duke's course API and GroupMe's API to place users in study groups based on common classes. 

## Notes

* Our current backend service is provided by Parse. Unfortunately, Facebook is closing Parse down. I recommend switching all backend methods over to Google's Firebase though there are other options. 
* We get the course list from the Duke Colab. They may have changed their API since February so you should double check that still works. 
* We form groups using the GroupMe API (users use GroupMe OAuth to login). You can try making groups within the app itself and implementing chat (it's not difficult since there's a lot of easy to use Swift chat libraries out there). 
* General UI improvements - this was our first iOS project (you can tell) and I'm sure there's a lot that can be improved 

Message me if you want to be added to the repo

## Useful resources:

[Swift OAuth tutorial](http://samwilskey.com/swift-oauth/)

[GroupMe Authentication] (https://dev.groupme.com/tutorials/oauth)

[Swift Deep Linking] (http://www.brianjcoleman.com/tutorial-deep-linking-in-swift/)

[Flow Chart](https://docs.google.com/document/d/1kFntG5n3PAH1CtYqMnnthyJpT6axjv3UPh1Rb7KuMuQ/edit)

[Planner/Documentation](https://docs.google.com/document/d/1T7yhHCTcnfTbc_NetQxIdNTA0ZWpndg39Ge1LgSEvPM/edit#) 


