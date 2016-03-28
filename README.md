# hoyahacks
RockLock - A home security app created for Hoya Hacks

## Description
RockLock is a home security app that was created for a Hoya Hacks, a hackathon. The idea behind this
app was to create an app that allows users and their family members to access the house. So to create
a proof of concept during the hackathon, the app was connected to an arduino in the backend and whenever
the user would "unlock the door", the arduino would flash green. Then the user would connect the app to
the arduino by registering the unique arduino code into the phone. Then the phone would connect with the 
backend and verify it. Once the arduino is registered, the owner has full access to "unlock the door". The 
coolest thing about this app was allowing the user to add family members to this app. We implmented this
by allowing the app to have a QRCodeScanner in the owner section, and each unique phone have its own 
unique QRCode. Once the owner scans the users QRCode, that user will also be able to "unlock the door".
Unfortunately we can not show you this implementation because the camera doesn't work in the simulator. 
So this app allows a quick way for the owner and his/her family members to unlock the door without a key 
and just use a phone. 


## User Stories / Implemenation

The following **required** functionality is completed:

- [x] Network requests and retriving to and from the server
- [x] Asynchrous processing data from the server
- [x] QRCode Scanner for the app
- [x] Loading Unique QRCode for each phone as an image
- [x] Table View Implementation in order for the user to see all the registered houses
- [x] Table View Implementation in order for the owner to see all the connections
- [x] Design and auto layout of the app

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/WW3ARrj.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Coudn't display much of the app in the simulator becausey you need the back end to be running.
Also couldn't display QRCode Scanner in the simulator because camera doesn't work in the simulator,
but you can see that each user of the app has his/her own unique QRCode that the owner can scan to
add different users.

Describe any challenges encountered while building the app.

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
