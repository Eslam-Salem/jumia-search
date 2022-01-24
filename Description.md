
## Notes

1. i'd like to achieve point 3 in the bouns points "Using SwiftUI Views along side UIKit Views." so i have changed min deployment target to ios 13 (it was 12.2) ans swift ui supports from ios 13.

2. layout is implemeted using swift ui, nib files and programmatically (no storyboards).

3. i'm not familier with RXSwift and RXCocoa before the task, but I tried my best.
 
4. network requests made by url sessions no third party libraries used.
 
  -------------------------------

## Project hirerachy

1. network Group it is respresent network layer it contains api client and enpoints.

2. Resources it contains app delegate, color and image assests.

3. utilities contains helper, extensions files and any shared files.

4. screenFlow contains app Modules.
 -------------------------------

## Implementation Description

1. first screen is splash screen "it is the same design of the launch screen" where configuration api has been called and configuration saved in a singlton class called user configuration.

2. second screen is product lists screen where "phone" is default string typed in search bar. user can search for products change search text by clicking on search icon at the right top bar.

3. by clicking on any product you will be navigated to product details screen.


-------------------------------

## Dependency manager
1. Swift package manager is the only dependency manager used.


-------------------------------

## Task duration.
1. I started working on the task "7 jan at 5:00 pm" (cairo time) 
and last technical commit is "9 jan at 1:30 pm: (cairo time)

